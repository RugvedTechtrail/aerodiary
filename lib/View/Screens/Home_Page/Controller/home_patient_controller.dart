import 'dart:developer';

import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constDatePicker.dart';
import 'package:aerodiary/widgets/constTextField.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:aerodiary/widgets/date_picker_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ConditionItem {
  final String name;
  RxBool isSelected;
  Rx<DateTime?> conditionFromDate;
  Rx<TextEditingController> dateController;
  RxBool dateConfirmed; // Add this new flag to track if date was confirmed

  ConditionItem({required this.name, required bool selected})
      : isSelected = selected.obs,
        conditionFromDate = Rx<DateTime?>(null),
        dateController = TextEditingController().obs,
        dateConfirmed = false.obs;
}

class PatientHistoryController extends GetxController {
  // List of conditions with their selection status
  final RxList<ConditionItem> conditions = <ConditionItem>[
    ConditionItem(name: 'Condition 1', selected: false),
    ConditionItem(name: 'Condition 2', selected: false),
    ConditionItem(name: 'Condition 3', selected: false),
    ConditionItem(name: 'Condition 4', selected: false),
    ConditionItem(name: 'Condition 5', selected: false),
    ConditionItem(name: 'Other', selected: false),
  ].obs;
  final medicationList = <MedicationItem>[].obs;

  // Selected medications lists
  final RxList<MedicationItem> selectedMaintenanceMedications =
      <MedicationItem>[].obs;
  final RxList<MedicationItem> selectedRescueMedications =
      <MedicationItem>[].obs;

  // Controller for the "Other" text field
  Rx<TextEditingController> otherConditionController =
      TextEditingController().obs;

  // Format date to display in text field
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  // Flag to show/hide the "Other" text field
  final RxBool showOtherTextField = false.obs;

  // Current page index to control which view to show
  final RxInt currentPageIndex = 0.obs;

  // Total number of pages
  final int totalPages = 5;

  // Page controller for slide animation
  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    loadMedications();
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    otherConditionController.value.dispose();
    // Dispose all date controllers
    for (var condition in conditions) {
      condition.dateController.value.dispose();
    }
    pageController.dispose();
    super.onClose();
  }

  String? validateOther(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the diseases';
    }

    return null;
  }

  void updateOther(String value) {
    String previousValue = otherConditionController.value.text;
    otherConditionController.value.text = value;

    // If this is the first time text is being entered (was empty, now has text),
    // automatically show the date picker
    if (previousValue.isEmpty && value.isNotEmpty) {
      // Find the index of the "Other" condition
      int otherIndex =
          conditions.indexWhere((condition) => condition.name == 'Other');
      if (otherIndex != -1 && conditions[otherIndex].isSelected.value) {
        // Use a short delay to allow UI to update first
        Future.delayed(Duration(milliseconds: 100), () {
          _showDatePickerDialog(otherIndex);
          print('Auto-showing date picker for Other condition: $value');
        });
      }
    }

    update(["conditions_list"]);
  }

  void toggleCondition(int index) {
    final condition = conditions[index];
    // Toggle selection
    condition.isSelected.toggle();

    print(
        'Toggle condition: ${condition.name}, selected: ${condition.isSelected.value}');

    // If the condition is unselected, also reset the date and confirmation
    if (!condition.isSelected.value) {
      condition.conditionFromDate.value = null;
      condition.dateController.value.clear();
      condition.dateConfirmed.value = false;
    }

    // If "Other" is selected or unselected, update the text field visibility
    if (condition.name == 'Other') {
      showOtherTextField.value = condition.isSelected.value;
      if (!showOtherTextField.value) {
        otherConditionController.value.clear();
      } else {
        // Check if there's text already and show dialog or focus text field
        if (otherConditionController.value.text.isNotEmpty) {
          print(
              'Other selected with existing text: ${otherConditionController.value.text}');
          // Show date picker if text is already entered
          Future.delayed(Duration(milliseconds: 100), () {
            _showDatePickerDialog(index);
          });
        } else {
          print('Other selected, waiting for text input');
          // We'll focus on text field and wait for input
          // The showOtherDatePicker() will be called from updateOther()
        }
      }
    }
    // For all other conditions, show date picker dialog when selected
    else if (condition.isSelected.value) {
      _showDatePickerDialog(index);
    }

    log('Selected condition is ${condition.name}');
    update(['conditions_list']);
  }

  void _showDatePickerDialog(int index) {
    // Unfocus any active text fields to dismiss the keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    final condition = conditions[index];
    final formKey = GlobalKey<FormState>();

    // Store original values to restore if canceled
    final originalDate = condition.conditionFromDate.value;
    final originalConfirmed = condition.dateConfirmed.value;

    // Handle date change
    void onDateChanged(String value) {
      // Unfocus any active text fields to dismiss the keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      // Parse the date from the format returned by ConstYearPicker (yyyy-MM-dd)
      condition.conditionFromDate.value = DateTime.parse(value);
      // Format it according to your desired format (dd/MM/yyyy)
      condition.dateController.value.text =
          dateFormat.format(condition.conditionFromDate.value!);

      print(
          'Date selected for ${condition.name}: ${condition.dateController.value.text}');
    }

    // Handle done button press
    void onDone() {
      if (formKey.currentState?.validate() ?? false) {
        if (condition.conditionFromDate.value != null) {
          // Mark date as confirmed only when Done is clicked and date is selected
          condition.dateConfirmed.value = true;
          Get.back();
          update(['conditions_list']);
          print(
              'Date confirmed for ${condition.name}: ${condition.dateController.value.text}');
        } else {
          // Show error or fallback behavior
          Get.snackbar(
            'Error',
            'Please select a date first',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    }

    // Handle cancel button press
    void onCancel() {
      // If canceled and no previous date was confirmed, unselect the condition
      if (!originalConfirmed) {
        condition.isSelected.value = false;
      } else {
        // Restore original values if there was a previously confirmed date
        condition.conditionFromDate.value = originalDate;
        condition.dateConfirmed.value = originalConfirmed;
      }
      Get.back();
      update(['conditions_list']);
    }

    // Customize the title and message for the "Other" condition
    String title = 'Selected : ${condition.name}';
    String message = 'Since when are you having ${condition.name}?';

    if (condition.name == 'Other' &&
        otherConditionController.value.text.isNotEmpty) {
      title = 'Selected : Other - ${otherConditionController.value.text}';
      message =
          'Since when are you having ${otherConditionController.value.text}?';
    }

    Get.dialog(
      ConditionDatePickerDialog(
        title: title,
        message: message,
        dateController: condition.dateController.value,
        onDateChanged: onDateChanged,
        onDone: onDone,
        onCancel: onCancel,
        formKey: formKey,
        initialDate: condition.conditionFromDate.value,
      ),
    );
  }

  // Method to select date

  List<Map<String, dynamic>> getSelectedConditionsWithDates() {
    final selectedConditionsWithDates =
        conditions.where((c) => c.isSelected.value).map((c) {
      if (c.name == 'Other') {
        return {
          'name': 'Other: ${otherConditionController.value.text}',
          'date': c.conditionFromDate.value,
          'dateString': c.conditionFromDate.value != null
              ? dateFormat.format(c.conditionFromDate.value!)
              : null,
        };
      } else {
        return {
          'name': c.name,
          'date': c.conditionFromDate.value,
          'dateString': c.conditionFromDate.value != null
              ? dateFormat.format(c.conditionFromDate.value!)
              : null,
        };
      }
    }).toList();

    log('Selected conditions with dates: $selectedConditionsWithDates');
    return selectedConditionsWithDates;
  }

  List<String> getSelectedConditions() {
    final selectedConditions =
        conditions.where((c) => c.isSelected.value).map((c) => c.name).toList();

    if (showOtherTextField.value &&
        otherConditionController.value.text.isNotEmpty) {
      selectedConditions.add('Other: ${otherConditionController.value.text}');
    }
    log('selected condion is $selectedConditions');
    return selectedConditions;
  }

  void goToNextPage() {
    // Process selected conditions if needed
    if (currentPageIndex.value == 0) {
      List<Map<String, dynamic>> selectedConditionsWithDates =
          getSelectedConditionsWithDates();
      log('Selected conditions with dates: $selectedConditionsWithDates');
    }

    // Check if we're not on the last page
    if (currentPageIndex.value < totalPages - 1) {
      // Increase page index and animate to next page
      currentPageIndex.value++;
      pageController.animateToPage(
        currentPageIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      log('selected maintenance medications: ${selectedMaintenanceMedications.length}');
      log('selected rescue medications: ${selectedRescueMedications.length}');
      log('Navigated to page ${currentPageIndex.value}');
      update(['page_container']);
    } else {
      // Already on the last page
      log('Already on the last page');
    }
  }

  void goToPreviousPage() {
    // Check if we can go back (not on the first page)
    if (currentPageIndex.value > 0) {
      // Decrease page index
      currentPageIndex.value--;

      // Animate to previous page
      pageController.animateToPage(
        currentPageIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      log('Navigated back to page ${currentPageIndex.value}');
      update(['page_container']);
    } else {
      // Already on the first page, could handle differently if needed
      log('Already on the first page');
    }
  }

  // Method to get the current page number (1-based for display purposes)
  int getCurrentPageNumber() {
    return currentPageIndex.value + 1;
  }

  // Method to get the page title based on the index
  String getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Respiratory Diseases';
      case 1:
        return 'Page 2';
      case 2:
        return 'Page 3';
      case 3:
        return 'Page 4';
      case 4:
        return 'Summary';
      default:
        return 'Unknown';
    }
  }

  void loadMedications() {
    medicationList.value = [
      MedicationItem(
        name: 'Innovair ® 100 μg + 6 μg',
        subtitle: 'inhalation aerosol',
        icon: Icons.medication_liquid_outlined,
      ),
      MedicationItem(
        name: 'Innovair ® 200 μg + 6 μg',
        subtitle: 'inhalation aerosol',
        icon: Icons.medication_liquid_outlined,
      ),
      MedicationItem(
        name: 'Innovair ® NEXThaler 100 μg + 6 μg',
        subtitle: 'dry powder inhaler',
        icon: Icons.circle_outlined,
      ),
      MedicationItem(
        name: 'AB-Flo 100 100 mg',
        subtitle: 'tablets',
        icon: Icons.grid_4x4_outlined,
      ),
      MedicationItem(
        name: 'Advair 100 μg',
        subtitle: 'dry powder inhaler',
        icon: Icons.circle_outlined,
      ),
      MedicationItem(
        name: 'Advair 250 μg',
        subtitle: 'dry powder inhaler',
        icon: Icons.circle_outlined,
      ),
      MedicationItem(
        name: 'Advair 500 μg',
        subtitle: 'dry powder inhaler',
        icon: Icons.circle_outlined,
      ),
      MedicationItem(
        name: 'Advair 115 μg',
        subtitle: 'inhalation aerosol',
        icon: Icons.medication_liquid_outlined,
      ),
      MedicationItem(
        name: 'Aerius 5 mg',
        subtitle: 'tablets',
        icon: Icons.grid_4x4_outlined,
      ),
      MedicationItem(
        name: 'Aerius (syrop) 0,5 mg/ml',
        subtitle: 'solution',
        icon: Icons.local_drink_outlined,
      ),
      MedicationItem(
        name: 'Aerocort Rotacaps Forte 200 mcg',
        subtitle: 'dry powder capsule inhaler',
        icon: Icons.circle_outlined,
      ),
      MedicationItem(
        name: 'Aerolin® 100 μg',
        subtitle: 'inhalation aerosol',
        icon: Icons.medication_liquid_outlined,
      ),
      MedicationItem(
        name: 'Ahist 5 mg',
        subtitle: 'tablets',
        icon: Icons.grid_4x4_outlined,
      ),
    ];
  }

  // Add medication to either maintenance or rescue list
  void addMedication(MedicationItem medication, bool isMaintenanceMedication) {
    if (isMaintenanceMedication) {
      // Check if medication is already in the list to avoid duplicates
      if (!selectedMaintenanceMedications
          .any((med) => med.name == medication.name)) {
        selectedMaintenanceMedications.add(medication);
        log('Added ${medication.name} to Maintenance Medications');
      }
    } else {
      if (!selectedRescueMedications
          .any((med) => med.name == medication.name)) {
        selectedRescueMedications.add(medication);
        log('Added ${medication.name} to Rescue Medications');
      }
    }

    // Log the current medication lists
    log('==== CURRENT MEDICATION LISTS ====');
    log('Maintenance Medications: ${selectedMaintenanceMedications.map((med) => med.name).join(", ")}');
    log('Rescue Medications: ${selectedRescueMedications.map((med) => med.name).join(", ")}');
    log('=================================');

    update(['medications_list']);
  }

  // Remove medication from the appropriate list
  void removeMedication(
      MedicationItem medication, bool isMaintenanceMedication) {
    if (isMaintenanceMedication) {
      selectedMaintenanceMedications
          .removeWhere((med) => med.name == medication.name);
    } else {
      selectedRescueMedications
          .removeWhere((med) => med.name == medication.name);
    }
    update(['medications_list']);
  }

  // Set medication frequency
  void setMedicationFrequency(MedicationItem medication, int value) {
    medication.frequency.value = value;
    log('Setting medication frequency for ${medication.name} to: $value');
    update(['medications_list']);
  }

  // Set medication dosage
  void setMedicationDosage(MedicationItem medication, int value) {
    medication.dosage.value = value;
    log('Setting medication dosage for ${medication.name} to: $value');
    update(['medications_list']);
  }

  // Add reminder for medication
  void addMedicationReminder(MedicationItem medication, String reminder) {
    if (!medication.reminders.contains(reminder)) {
      medication.reminders.add(reminder);
      update(['medications_list']);
    }
  }

  // Remove reminder for medication
  void removeMedicationReminder(MedicationItem medication, String reminder) {
    medication.reminders.remove(reminder);
    update(['medications_list']);
  }

  // Method to show date picker for "Other" condition after text input
  void showOtherDatePicker() {
    // Find the index of the "Other" condition
    int otherIndex =
        conditions.indexWhere((condition) => condition.name == 'Other');
    if (otherIndex != -1 && conditions[otherIndex].isSelected.value) {
      // Show the date picker dialog for the "Other" condition
      _showDatePickerDialog(otherIndex);
      print(
          'Showing date picker for Other condition: ${otherConditionController.value.text}');
    }
  }
}

class MedicationItem {
  final String name;
  final String subtitle;
  final IconData icon;
  // Update fields for medication details
  RxInt frequency = 0.obs; // 0: none, 1: once a day, 2: twice a day
  RxInt dosage = 0.obs; // 0: none, 1: one puff, 2: two puffs
  RxList<String> reminders = <String>[].obs;

  MedicationItem({
    required this.name,
    required this.subtitle,
    required this.icon,
  });
}
