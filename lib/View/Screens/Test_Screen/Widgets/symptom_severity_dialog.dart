import 'package:aerodiary/View/Screens/Test_Screen/Controller/test_controller.dart';
import 'package:aerodiary/View/Screens/Test_Screen/Widgets/severity_selector.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SymptomSeverityDialog extends StatelessWidget {
  final TestScreenController controller;

  const SymptomSeverityDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      decoration: BoxDecoration(
        color: ConstColors.white,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: ConstColors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp),
              ),
            ),
            child: Text(
              'Selected: Yes',
              style: getTextTheme(
                color: ConstColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ).bodyLarge,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: ConstColors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //  mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'How severe were the symptoms?',
                  style: getTextTheme(
                    color: ConstColors.darkGrey,
                    fontSize: 16.sp,
                  ).bodyMedium,
                ),
                Text(
                  'Please select severity for all symptoms',
                  style: getTextTheme(
                    color: ConstColors.darkGrey.withOpacity(0.7),
                    fontSize: 14.sp,
                  ).bodySmall,
                ),
                SizedBox(height: 10.h),

                // Use Container with fixed height instead of Flexible
                Container(
                  // height: 200.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Symptom severity selectors
                        Obx(() => SeveritySelector(
                              symptomName: 'Coughing',
                              selectedSeverity:
                                  controller.symptomSeverity['Coughing'] ?? '',
                              onSeverityChanged: (severity) => controller
                                  .updateSymptomSeverity('Coughing', severity),
                            )),

                        Obx(() => SeveritySelector(
                              symptomName: 'Wheezing',
                              selectedSeverity:
                                  controller.symptomSeverity['Wheezing'] ?? '',
                              onSeverityChanged: (severity) => controller
                                  .updateSymptomSeverity('Wheezing', severity),
                            )),

                        Obx(() => SeveritySelector(
                              symptomName: 'Congestion',
                              selectedSeverity:
                                  controller.symptomSeverity['Congestion'] ??
                                      '',
                              onSeverityChanged: (severity) =>
                                  controller.updateSymptomSeverity(
                                      'Congestion', severity),
                            )),

                        Obx(() => SeveritySelector(
                              symptomName: 'Breathlessness',
                              selectedSeverity: controller
                                      .symptomSeverity['Breathlessness'] ??
                                  '',
                              onSeverityChanged: (severity) =>
                                  controller.updateSymptomSeverity(
                                      'Breathlessness', severity),
                            )),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15.h),

                // Next button
                Container(
                  width: double.infinity,
                  height: 45.h,
                  child: Obx(() => ElevatedButton(
                        onPressed: controller.symptomSeverityComplete.value
                            ? () {
                                // Go back to the main flow and continue
                                Get.back();
                                controller.nextQuestion();
                              }
                            : null, // Disable button if not all symptoms are rated
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstColors.buttonColor,
                          disabledBackgroundColor:
                              ConstColors.darkGrey.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                        ),
                        child: Text(
                          'Next',
                          style: getTextTheme(
                            color: ConstColors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ).bodyLarge,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
