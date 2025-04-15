import 'package:aerodiary/View/Screens/Home_Page/Controller/home_patient_controller.dart';
import 'package:aerodiary/View/Screens/Home_Page/Widgets/medication_details_widget.dart';
import 'package:aerodiary/View/Screens/Home_Page/Widgets/snack_bar.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicationPageWidget extends StatelessWidget {
  final PatientHistoryController controller;

  const MedicationPageWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: ConstColors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header section with blue color
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  color: ConstColors.blue,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "M",
                          style: getTextTheme(
                            color: ConstColors.blue,
                            fontWeight: FontWeight.bold,
                          ).bodyMedium,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Medication',
                      style: getTextTheme(
                        color: Colors.white,
                      ).bodyMedium,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Medication content - both maintenance and rescue
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Maintenance Medication section
                        MedicationSection(
                          title: 'Maintenance Medication',
                          placeholder: 'Add medication',
                          controller: controller,
                        ),

                        SizedBox(height: 16.h),

                        // Rescue Medication section
                        MedicationSection(
                          title: 'Rescue Medication',
                          placeholder: 'Add medication',
                          controller: controller,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ConstantButton(
                height: 45.h,
                horiPadding: 15.w,
                vertiPadding: 30.h,
                press: () {
                  // Proceed to next page if at least one condition is selected
                  controller.goToPreviousPage();
                },
                text: "Back",
                borderRadius: 8.sp,
                color: ConstColors.buttonColor,
                bordercolor: ConstColors.buttonColor,
                style: getTextTheme(
                  fontWeight: FontWeight.w500,
                ).bodyMedium,
              ),
              ConstantButton(
                height: 45.h,
                horiPadding: 15.w,
                vertiPadding: 5.h,
                press: () {
                  // Log all selected medications
                  print('==== FINAL MEDICATION SELECTIONS ====');
                  print('MAINTENANCE MEDICATIONS:');
                  controller.selectedMaintenanceMedications.forEach((med) {
                    print('- ${med.name} (${med.subtitle})');
                    print(
                        '  Frequency: ${med.frequency.value == 1 ? "Once a day" : "Twice a day"}');
                    print(
                        '  Dosage: ${med.dosage.value == 1 ? "One puff" : "Two puffs"}');
                    print('  Reminders: ${med.reminders.join(", ")}');
                  });
                  print('RESCUE MEDICATIONS:');
                  controller.selectedRescueMedications.forEach((med) {
                    print('- ${med.name} (${med.subtitle})');
                    print(
                        '  Frequency: ${med.frequency.value == 1 ? "Once a day" : "Twice a day"}');
                    print(
                        '  Dosage: ${med.dosage.value == 1 ? "One puff" : "Two puffs"}');
                    print('  Reminders: ${med.reminders.join(", ")}');
                  });
                  print('==================================');

                  // Go back or to next screen
                  controller.goToNextPage();
                },
                text: "Done",
                borderRadius: 8.sp,
                color: ConstColors.buttonColor,
                bordercolor: ConstColors.buttonColor,
                style: getTextTheme(
                  fontWeight: FontWeight.w500,
                ).bodyMedium,
              ),
              // Done button
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Log all selected medications
              //       print('==== FINAL MEDICATION SELECTIONS ====');
              //       print('MAINTENANCE MEDICATIONS:');
              //       controller.selectedMaintenanceMedications.forEach((med) {
              //         print('- ${med.name} (${med.subtitle})');
              //         print(
              //             '  Frequency: ${med.frequency.value == 1 ? "Once a day" : "Twice a day"}');
              //         print(
              //             '  Dosage: ${med.dosage.value == 1 ? "One puff" : "Two puffs"}');
              //         print('  Reminders: ${med.reminders.join(", ")}');
              //       });
              //       print('RESCUE MEDICATIONS:');
              //       controller.selectedRescueMedications.forEach((med) {
              //         print('- ${med.name} (${med.subtitle})');
              //         print(
              //             '  Frequency: ${med.frequency.value == 1 ? "Once a day" : "Twice a day"}');
              //         print(
              //             '  Dosage: ${med.dosage.value == 1 ? "One puff" : "Two puffs"}');
              //         print('  Reminders: ${med.reminders.join(", ")}');
              //       });
              //       print('==================================');

              //       // Go back or to next screen
              //       controller.goToNextPage();
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.teal,
              //       padding: EdgeInsets.symmetric(vertical: 14.h),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(6.r),
              //       ),
              //     ),
              //     child: Text(
              //       'Done',
              //       style: getTextTheme(
              //         color: Colors.white,
              //         fontSize: 16.sp,
              //         fontWeight: FontWeight.w500,
              //       ).bodyMedium,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicationSection extends StatelessWidget {
  final String title;
  final String placeholder;
  final PatientHistoryController controller;

  const MedicationSection({
    Key? key,
    required this.title,
    required this.placeholder,
    required this.controller,
  }) : super(key: key);

  bool get isMaintenanceMedication => title == 'Maintenance Medication';

  // Get the appropriate medication list based on the section type
  List<MedicationItem> get medicationsList => isMaintenanceMedication
      ? controller.selectedMaintenanceMedications
      : controller.selectedRescueMedications;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: ConstColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: getTextTheme(
                  color: ConstColors.darkGrey,
                  fontWeight: FontWeight.w500,
                ).bodyMedium,
              ),
              InkWell(
                onTap: () {
                  _showMedicationDialog(context);
                },
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: const BoxDecoration(
                    color: ConstColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16.sp,
                    color: ConstColors.white,
                  ),
                ),
              ),
            ],
          ),
          // Display selected medications or placeholder
          GetBuilder<PatientHistoryController>(
            id: 'medications_list',
            builder: (_) {
              if (medicationsList.isEmpty) {
                // Show placeholder when no medications are selected
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: ConstColors.white,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Text(
                    placeholder,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                );
              } else {
                // Show list of selected medications with arrow icons
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ConstColors.white,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Column(
                    children: medicationsList.map((medication) {
                      return _buildSelectedMedicationTile(medication, context);
                    }).toList(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Build a tile for selected medications with arrow icon for navigation
  Widget _buildSelectedMedicationTile(
      MedicationItem medication, BuildContext context) {
    return InkWell(
      onTap: () {
        // Open medication details screen for the new medication
        Get.back(); // Close current dialog
        Get.to(() => MedicationDetailsWidget(
              medication: medication,
              controller: controller,
              isMaintenanceMedication: isMaintenanceMedication,
              isNewMedication: true,
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ConstColors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      medication.icon,
                      color: Colors.indigo.shade400,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medication.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.indigo,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          medication.subtitle,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                // Show medication details if available
                // if (medication.frequency.value != 0)
                //   Container(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                //     decoration: BoxDecoration(
                //       color: Colors.grey.shade200,
                //       borderRadius: BorderRadius.circular(4.r),
                //     ),
                //     child: Text(
                //       medication.frequency.value == 1
                //           ? 'Once a day'
                //           : 'Twice a day',
                //       style: TextStyle(
                //         color: Colors.grey.shade700,
                //         fontSize: 10.sp,
                //       ),
                //     ),
                //   ),
                // SizedBox(width: 8.w),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMedicationDialog(BuildContext context) {
    // Add a search controller for the search bar
    final TextEditingController searchController = TextEditingController();
    // Add a RxList to hold filtered medications
    final filteredMedications =
        RxList<MedicationItem>.from(controller.medicationList);

    // Add a search function
    void searchMedications(String query) {
      if (query.isEmpty) {
        filteredMedications.value = controller.medicationList;
      } else {
        filteredMedications.value = controller.medicationList
            .where((medication) =>
                medication.name.toLowerCase().contains(query.toLowerCase()) ||
                medication.subtitle.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    }

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    decoration: BoxDecoration(
                      color: isMaintenanceMedication
                          ? ConstColors.blue
                          : ConstColors.orange,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 20.w,
                                height: 20.h,
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
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  title,
                                  style: getTextTheme().bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                          height: 40.h,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
                  Container(
                    color: ConstColors.grey.withOpacity(0.3),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: searchMedications,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade400,
                            size: 20.sp,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                      ),
                    ),
                  ),

                  // Info Box
                  Container(
                    padding:
                        EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
                    decoration: BoxDecoration(
                      color: ConstColors.grey.withOpacity(0.3),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 10.w),
                          child: Text(
                            isMaintenanceMedication
                                ? 'Choose your maintenance medication. This is the medication you take regularly to control your asthma.'
                                : 'Choose your rescue medication. This is the medication you take when you have acute symptoms.',
                            style: getTextTheme(
                              color: ConstColors.darkGrey,
                              fontSize: 12.sp,
                            ).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Medication List
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    color: ConstColors.grey.withOpacity(0.3),
                    child: Obx(() => ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredMedications.length,
                          itemBuilder: (context, index) {
                            final medication = filteredMedications[index];
                            // Check if medication is already selected
                            final bool isAlreadySelected =
                                isMaintenanceMedication
                                    ? controller.selectedMaintenanceMedications
                                        .any((med) =>
                                            med.name == medication.name)
                                    : controller.selectedRescueMedications.any(
                                        (med) => med.name == medication.name);

                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                ),
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    medication.icon,
                                    color: Colors.indigo.shade400,
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  medication.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.indigo.shade700,
                                  ),
                                ),
                                subtitle: Text(
                                  medication.subtitle,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                                trailing: isAlreadySelected
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green.shade400,
                                        size: 20,
                                      )
                                    : Icon(
                                        Icons.chevron_right,
                                        color: Colors.grey.shade400,
                                        size: 20,
                                      ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                onTap: () {
                                  // Open medication details screen for the new medication
                                  Get.back(); // Close current dialog
                                  Get.to(() => MedicationDetailsWidget(
                                        medication: medication,
                                        controller: controller,
                                        isMaintenanceMedication:
                                            isMaintenanceMedication,
                                        isNewMedication: true,
                                      ));
                                },
                              ),
                            );
                          },
                        )),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
