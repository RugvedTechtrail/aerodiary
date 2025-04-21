import 'package:aerodiary/View/Screens/Test_Screen/Controller/test_controller.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RescueFrequencyDialog extends StatelessWidget {
  final TestScreenController controller;

  const RescueFrequencyDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Clear any previously selected frequency when dialog opens
    controller.rescueInhalerAnswer.value = '';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
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
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: ConstColors.buttonColor,
              borderRadius: BorderRadius.circular(5.sp),
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
          SizedBox(height: 15.h),
          Text(
            'How many times did you need to use your rescue, or quickrelief medication today ?',
            style: getTextTheme(
              color: ConstColors.darkGrey,
              fontSize: 16.sp,
            ).bodyMedium,
          ),
          SizedBox(height: 10.h),

          // List of frequency options
          ...controller.rescueFrequency
              .map((frequency) => Obx(() => _buildFrequencyOption(
                    frequency,
                    controller.rescueInhalerAnswer.value == frequency,
                    () => controller.setRescueFrequency(frequency),
                  )))
              .toList(),

          SizedBox(height: 15.h),

          // Next button
          Container(
            width: double.infinity,
            height: 50.h,
            child: Obx(() => ElevatedButton(
                  onPressed: controller.rescueInhalerAnswer.value.isNotEmpty
                      ? () {
                          // Go back to the main flow and continue
                          Get.back();
                          controller.nextQuestion();
                        }
                      : null, // Disable button if no frequency selected
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
    );
  }

  Widget _buildFrequencyOption(
    String frequency,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? ConstColors.primary
                      : ConstColors.darkGrey.withOpacity(0.3),
                  width: 2.sp,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 14.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ConstColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 10.w),
            Text(
              frequency,
              style: getTextTheme(
                color: ConstColors.darkGrey,
                fontSize: 16.sp,
              ).bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
