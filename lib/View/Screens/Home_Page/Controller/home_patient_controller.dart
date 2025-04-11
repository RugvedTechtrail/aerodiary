import 'dart:developer';

import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constDatePicker.dart';
import 'package:aerodiary/widgets/constTextField.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// class ConditionItem {
//   final String name;
//   RxBool isSelected;

//   ConditionItem({required this.name, required bool selected})
//       : isSelected = selected.obs;
// }

// class PatientHistoryController extends GetxController {
//   // List of conditions with their selection status
//   final RxList<ConditionItem> conditions = <ConditionItem>[
//     ConditionItem(name: 'Condition 1', selected: false),
//     ConditionItem(name: 'Condition 2', selected: false),
//     ConditionItem(name: 'Condition 3', selected: false),
//     ConditionItem(name: 'Condition 4', selected: false),
//     ConditionItem(name: 'Condition 5', selected: false),
//     ConditionItem(name: 'Other', selected: false),
//   ].obs;

//   // Controller for the "Other" text field
//   final TextEditingController otherConditionController =
//       TextEditingController();

//   // Flag to show/hide the "Other" text field
//   final RxBool showOtherTextField = false.obs;

//   // Current page index to control which view to show
//   final RxInt currentPageIndex = 0.obs;

//   // Page controller for slide animation
//   late final PageController pageController;

//   @override
//   void onInit() {
//     super.onInit();
//     pageController = PageController(initialPage: 0);
//   }

//   @override
//   void onClose() {
//     otherConditionController.dispose();
//     pageController.dispose();
//     super.onClose();
//   }

//   void toggleCondition(int index) {
//     conditions[index].isSelected.toggle();

//     // If "Other" is selected or unselected, update the text field visibility
//     if (conditions[index].name == 'Other') {
//       showOtherTextField.value = conditions[index].isSelected.value;
//       if (!showOtherTextField.value) {
//         otherConditionController.clear();
//       }
//     }
//     log('Selected condition is ${conditions[index].name}');
//     update(['conditions_list']);
//   }

//   List<String> getSelectedConditions() {
//     final selectedConditions =
//         conditions.where((c) => c.isSelected.value).map((c) => c.name).toList();

//     if (showOtherTextField.value && otherConditionController.text.isNotEmpty) {
//       selectedConditions.add('Other: ${otherConditionController.text}');
//     }
//     log('selected condion is $selectedConditions');
//     return selectedConditions;
//   }

//   void goToNextPage() {
//     // Process selected conditions if needed
//     List<String> selectedConditions = getSelectedConditions();
//     log('Selected conditions: $selectedConditions');

//     // Increase page index and animate to next page
//     currentPageIndex.value++;
//     pageController.animateToPage(
//       currentPageIndex.value,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//     log('Navigated  to page ${currentPageIndex.value}');
//     update(['page_container']);
//   }

//   void goToPreviousPage() {
//     // Check if we can go back (not on the first page)
//     if (currentPageIndex.value > 0) {
//       // Decrease page index
//       currentPageIndex.value--;

//       // Animate to previous page
//       pageController.animateToPage(
//         currentPageIndex.value,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );

//       log('Navigated back to page ${currentPageIndex.value}');
//       update(['page_container']);
//     } else {
//       // Already on the first page, could handle differently if needed
//       log('Already on the first page');
//     }
//   }
// }

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
    otherConditionController.value.text = value;
    update(["conditions_list"]);
  }

  void toggleCondition(int index) {
    final condition = conditions[index];
    // Toggle selection
    condition.isSelected.toggle();

    // If the condition is unselected, also reset the date and confirmation
    if (!condition.isSelected.value) {
      condition.conditionFromDate.value = null;
      condition.dateController.value.clear();
      condition.dateConfirmed.value = false;
    }

    // If the condition is selected and it's not "Other", show date picker dialog
    if (condition.isSelected.value && condition.name != 'Other') {
      _showDatePickerDialog(index);
    }

    // If "Other" is selected or unselected, update the text field visibility
    if (condition.name == 'Other') {
      showOtherTextField.value = condition.isSelected.value;
      if (!showOtherTextField.value) {
        otherConditionController.value.clear();
      }
    }

    log('Selected condition is ${condition.name}');
    update(['conditions_list']);
  }

  void _showDatePickerDialog(int index) {
    final condition = conditions[index];
    final formKey = GlobalKey<FormState>();

    // Store original values to restore if canceled
    final originalDate = condition.conditionFromDate.value;
    final originalConfirmed = condition.dateConfirmed.value;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: ConstColors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 16.w,
                              height: 16.h,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Selected : ${condition.name}',
                          style: getTextTheme().bodyMedium,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
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
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 20.h,
                  left: 10.w,
                  right: 10.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.sp),
                    bottomRight: Radius.circular(10.sp),
                  ),
                  color: ConstColors.grey.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                      child: Text(
                        'Since when are you having ${condition.name}?',
                        style: getTextTheme(
                          color: ConstColors.darkGrey,
                        ).bodyMedium,
                      ),
                    ),
                    ConstYearPicker(
                      controller: condition.dateController.value,
                      hintText: 'Select Date',
                      textStyle: GoogleFonts.content(
                        fontWeight: FontWeight.w400,
                        color: ConstColors.darkGrey,
                        fontSize: 16.sp,
                      ),
                      hintStyle: GoogleFonts.content(
                        fontWeight: FontWeight.w400,
                        color: ConstColors.grey,
                        fontSize: 16.sp,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Parse the date from the format returned by ConstYearPicker (yyyy-MM-dd)
                        condition.conditionFromDate.value =
                            DateTime.parse(value);
                        // Format it according to your desired format (dd/MM/yyyy)
                        condition.dateController.value.text = dateFormat
                            .format(condition.conditionFromDate.value!);
                      },
                      onSaved: (p0) {},
                      iconColor: ConstColors.darkGrey,
                    ),
                    ConstantButton(
                      height: 45.h,
                      horiPadding: 15.w,
                      vertiPadding: 40.h,
                      press: () {
                        if (formKey.currentState?.validate() ?? false) {
                          if (condition.conditionFromDate.value != null) {
                            // Mark date as confirmed only when Done is clicked and date is selected
                            condition.dateConfirmed.value = true;
                            Get.back();
                            update(['conditions_list']);
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
                      },
                      text: "Done",
                      borderRadius: 8.sp,
                      color: ConstColors.buttonColor,
                      bordercolor: ConstColors.buttonColor,
                      style: getTextTheme(
                        fontWeight: FontWeight.w500,
                      ).bodyMedium,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
}

class MedicationItem {
  final String name;
  final String subtitle;
  final IconData icon;

  MedicationItem({
    required this.name,
    required this.subtitle,
    required this.icon,
  });
}
