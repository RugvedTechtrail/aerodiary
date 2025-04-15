import 'package:aerodiary/View/Screens/Home_Page/Controller/home_patient_controller.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MedicationDetailsWidget extends StatelessWidget {
  final MedicationItem medication;
  final PatientHistoryController controller;
  final bool isMaintenanceMedication;
  final bool
      isNewMedication; // Flag to indicate if this is a new medication being added

  const MedicationDetailsWidget({
    Key? key,
    required this.medication,
    required this.controller,
    required this.isMaintenanceMedication,
    this.isNewMedication = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController reminder1Controller = TextEditingController();
    final TextEditingController reminder2Controller = TextEditingController();

    // For existing medications, we initialize values if they're empty
    // For new medications, we leave them at their default values (0)
    if (!isNewMedication) {
      if (medication.frequency.value == 0) {
        medication.frequency.value = 1;
      }

      if (medication.dosage.value == 0) {
        medication.dosage.value = 1;
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () async {
              await GetStorage().erase();
              Get.toNamed('/starting_screen');
            },
            icon: Icon(
              Icons.settings,
              color: ConstColors.darkGrey.withOpacity(0.6),
              size: 30.sp,
            ),
          ),
          title: Text(
            'AeroDiary',
            style: getTextTheme(fontWeight: FontWeight.normal).headlineLarge,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: ConstColors.darkGrey.withOpacity(0.6),
                size: 30.sp,
              ),
            ),
            SizedBox(
              width: 10.w,
            )
          ],
          backgroundColor: ConstColors.primary,
          elevation: 0,
        ),
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              color: ConstColors.white,
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with medication name
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: ConstColors.blue,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${medication.name}: ${medication.subtitle}',
                          style: getTextTheme(
                            color: Colors.white,
                          ).bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  // Medication icon and dosage count
                  Container(
                    color: Colors.grey.shade100,
                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    child: Column(
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              medication.icon,
                              color: Colors.teal,
                              size: 50.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '180',
                          style: getTextTheme(
                            color: Colors.blue,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ).bodyLarge,
                        ),
                        Text(
                          'Dosages',
                          style: getTextTheme(
                            color: Colors.grey,
                            fontSize: 14.sp,
                          ).bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  // Frequency section
                  Container(
                    color: Colors.grey.shade300,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: Text(
                      'Frequency',
                      style: getTextTheme(
                        color: Colors.grey.shade700,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ).bodyMedium,
                    ),
                  ),

                  Container(
                    color: Colors.grey.shade100,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How often do you take this Medication?',
                          style: getTextTheme(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                          ).bodyMedium,
                        ),
                        SizedBox(height: 10.h),

                        // Frequency options
                        Obx(() => Column(
                              children: [
                                _buildRadioOption(
                                  'Once a day',
                                  1,
                                  medication.frequency.value,
                                  (value) => controller.setMedicationFrequency(
                                      medication, value),
                                ),
                                SizedBox(height: 5.h),
                                _buildRadioOption(
                                  'Twice a day',
                                  2,
                                  medication.frequency.value,
                                  (value) => controller.setMedicationFrequency(
                                      medication, value),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

                  // Doses section
                  Container(
                    color: Colors.grey.shade300,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: Text(
                      'Doses',
                      style: getTextTheme(
                        color: Colors.grey.shade700,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ).bodyMedium,
                    ),
                  ),

                  Container(
                    color: Colors.grey.shade100,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How many doses do you take per session?',
                          style: getTextTheme(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                          ).bodyMedium,
                        ),
                        SizedBox(height: 10.h),

                        // Dosage options
                        Obx(() => Column(
                              children: [
                                _buildRadioOption(
                                  'One puff',
                                  1,
                                  medication.dosage.value,
                                  (value) => controller.setMedicationDosage(
                                      medication, value),
                                ),
                                SizedBox(height: 5.h),
                                _buildRadioOption(
                                  'Two puffs',
                                  2,
                                  medication.dosage.value,
                                  (value) => controller.setMedicationDosage(
                                      medication, value),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

                  // Reminders section
                  Container(
                    color: Colors.grey.shade300,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reminders',
                          style: getTextTheme(
                            color: Colors.grey.shade700,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ).bodyMedium,
                        ),
                        InkWell(
                          onTap: () {
                            // Add a new reminder logic
                            if (medication.reminders.length < 2) {
                              medication.reminders.add(
                                  "Reminder ${medication.reminders.length + 1}");
                              controller.update(['medications_list']);
                              print(
                                  'Added reminder: Reminder ${medication.reminders.length}');
                            }
                          },
                          child: Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    color: Colors.grey.shade100,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    child: Obx(() => Column(
                          children: [
                            if (medication.reminders.isNotEmpty)
                              ...medication.reminders
                                  .map((reminder) => Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: TextField(
                                          controller: reminder ==
                                                  medication.reminders[0]
                                              ? reminder1Controller
                                              : reminder2Controller,
                                          decoration: InputDecoration(
                                            hintText: reminder,
                                            hintStyle: TextStyle(
                                              color: Colors.grey.shade500,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList()
                            else
                              SizedBox(height: 10.h),
                          ],
                        )),
                  ),

                  // Done button

                  Padding(
                    padding: EdgeInsets.all(16.h),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate selections
                        if (medication.frequency.value == 0) {
                          Get.snackbar(
                            'Error',
                            'Please select a frequency',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        if (medication.dosage.value == 0) {
                          Get.snackbar(
                            'Error',
                            'Please select a dosage',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        // Save reminders if entered
                        if (reminder1Controller.text.isNotEmpty &&
                            medication.reminders.isNotEmpty) {
                          medication.reminders[0] = reminder1Controller.text;
                        }
                        if (reminder2Controller.text.isNotEmpty &&
                            medication.reminders.length > 1) {
                          medication.reminders[1] = reminder2Controller.text;
                        }

                        // If this is a new medication, add it to the appropriate list
                        if (isNewMedication) {
                          controller.addMedication(
                              medication, isMaintenanceMedication);
                        }

                        // Log all selected data
                        print('==== MEDICATION DETAILS ====');
                        print(
                            'Medication: ${medication.name} (${medication.subtitle})');
                        print(
                            'Frequency: ${medication.frequency.value == 1 ? "Once a day" : "Twice a day"}');
                        print(
                            'Dosage: ${medication.dosage.value == 1 ? "One puff" : "Two puffs"}');
                        print('Reminders: ${medication.reminders.join(", ")}');
                        print('===========================');

                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: getTextTheme(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ).bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildRadioOption(
      String text, int value, int groupValue, Function(int) onChanged) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: groupValue,
          onChanged: (val) {
            if (val != null) {
              onChanged(val);
              print('Selected frequency: $text (value: $val)');
            }
          },
          activeColor: Colors.blue,
        ),
        Text(
          text,
          style: getTextTheme(
            color: Colors.grey.shade700,
            fontSize: 14.sp,
          ).bodyMedium,
        ),
      ],
    );
  }
}
