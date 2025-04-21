import 'package:aerodiary/View/Screens/Test_Screen/Controller/test_controller.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TriggerSelectorDialog extends StatelessWidget {
  final TestScreenController controller;

  const TriggerSelectorDialog({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Clear any previously selected triggers when dialog opens
    if (controller.selectedTriggers.isEmpty) {
      controller.otherTrigger.value = '';
    }

    return Container(
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
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: ConstColors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please Select your triggers',
                  style: getTextTheme(
                    color: ConstColors.darkGrey,
                    fontSize: 16.sp,
                  ).bodyMedium,
                ),
                Text(
                  '(Multiple Choice)',
                  style: getTextTheme(
                    color: ConstColors.darkGrey.withOpacity(0.7),
                    fontSize: 14.sp,
                  ).bodySmall,
                ),
                SizedBox(height: 10.h),

                // List of triggers - use Container with fixed height instead of Flexible
                Container(
                  height: 200.h, // Fixed height
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...controller.triggersList
                            .map((trigger) => Obx(() => _buildTriggerOption(
                                  trigger,
                                  controller.selectedTriggers.contains(trigger),
                                  (isSelected) {
                                    controller.toggleSelectedTrigger(
                                        trigger, isSelected);
                                  },
                                  trigger == 'Others'
                                      ? Obx(() => controller.selectedTriggers
                                              .contains('Others')
                                          ? TextField(
                                              onChanged:
                                                  controller.updateOtherTrigger,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Specify other triggers',
                                                hintStyle: TextStyle(
                                                  color: ConstColors.darkGrey
                                                      .withOpacity(0.5),
                                                  fontSize: 14.sp,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.sp),
                                                  borderSide: BorderSide(
                                                    color: ConstColors.darkGrey
                                                        .withOpacity(0.3),
                                                  ),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 5.h,
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink())
                                      : null,
                                )))
                            .toList(),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 45.h,
                  margin: EdgeInsets.symmetric(vertical: 15.w),
                  child: Obx(() => ElevatedButton(
                        onPressed: _isValidSelection()
                            ? () {
                                // Go back to the main flow and continue
                                Get.back();
                                controller.nextQuestion();
                              }
                            : null, // Disable button if no triggers selected or "Others" selected but no text
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

          // Next button
        ],
      ),
    );
  }

  bool _isValidSelection() {
    // Check if at least one trigger is selected
    if (controller.selectedTriggers.isEmpty) {
      return false;
    }

    // If "Others" is selected, check if other trigger text is provided
    if (controller.selectedTriggers.contains('Others') &&
        controller.otherTrigger.value.isEmpty) {
      return false;
    }

    return true;
  }

  Widget _buildTriggerOption(
    String trigger,
    bool isSelected,
    Function(bool) onChanged,
    Widget? additionalWidget,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => onChanged(!isSelected),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24.w,
                  height: 24.h,
                  margin: EdgeInsets.only(top: 8.h),
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
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ConstColors.primary,
                            ),
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    trigger,
                    style: getTextTheme(
                      color: ConstColors.darkGrey,
                      fontSize: 14.sp,
                    ).bodyMedium,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (additionalWidget != null)
          Padding(
            padding: EdgeInsets.only(left: 34.w),
            child: additionalWidget,
          ),
      ],
    );
  }
}
