import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

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

  ConditionItem({required this.name, required bool selected})
      : isSelected = selected.obs;
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

  // Controller for the "Other" text field
  final TextEditingController otherConditionController =
      TextEditingController();

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
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    otherConditionController.dispose();
    pageController.dispose();
    super.onClose();
  }

  void toggleCondition(int index) {
    conditions[index].isSelected.toggle();

    // If "Other" is selected or unselected, update the text field visibility
    if (conditions[index].name == 'Other') {
      showOtherTextField.value = conditions[index].isSelected.value;
      if (!showOtherTextField.value) {
        otherConditionController.clear();
      }
    }
    log('Selected condition is ${conditions[index].name}');
    update(['conditions_list']);
  }

  List<String> getSelectedConditions() {
    final selectedConditions =
        conditions.where((c) => c.isSelected.value).map((c) => c.name).toList();

    if (showOtherTextField.value && otherConditionController.text.isNotEmpty) {
      selectedConditions.add('Other: ${otherConditionController.text}');
    }
    log('selected condion is $selectedConditions');
    return selectedConditions;
  }

  void goToNextPage() {
    // Process selected conditions if needed
    if (currentPageIndex.value == 0) {
      List<String> selectedConditions = getSelectedConditions();
      log('Selected conditions: $selectedConditions');
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
}
