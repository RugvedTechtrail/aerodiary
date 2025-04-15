import 'package:aerodiary/View/Screens/Home_Page/Controller/home_patient_controller.dart';
import 'package:aerodiary/View/Screens/Home_Page/Widgets/condition_item_widget.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constTextField.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ConditionsPageWidget extends StatelessWidget {
  final PatientHistoryController controller;

  const ConditionsPageWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header section with green background
          _buildHeader(),

          // List of conditions with checkboxes
          _buildConditionsList(),

          // "Other" text field (shown conditionally)

          // Navigation buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: ConstColors.buttonColor,
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
                'Respiratory Diseases',
                style: getTextTheme().bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConditionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                child: Text(
                  'Please choose one or more respiratory diseases you are currently having.',
                  style: getTextTheme(
                    color: ConstColors.darkGrey,
                  ).bodyMedium,
                ),
              ),

              // List of conditions
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: GetBuilder<PatientHistoryController>(
                  id: 'conditions_list',
                  builder: (_) => Column(
                    children: [
                      ...List.generate(
                        controller.conditions.length,
                        (index) => ConditionItemWidget(
                          controller: controller,
                          index: index,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildOtherTextField(),
            ],
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildOtherTextField() {
    // Create a FocusNode to automatically focus the text field
    final FocusNode otherFocusNode = FocusNode();

    return Obx(() {
      if (controller.showOtherTextField.value) {
        // Use Future.delayed to focus the text field after it's built
        Future.delayed(Duration(milliseconds: 300), () {
          // Request focus to the text field
          FocusScope.of(Get.context!).requestFocus(otherFocusNode);
        });

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 35.w, right: 15.w, top: 10.h),
              child: ConstTextField(
                iconss: const SizedBox(),
                customText: 'Type other conditions',
                hintStyle: GoogleFonts.content(
                  fontWeight: FontWeight.w400,
                  color: ConstColors.grey,
                  fontSize: 16.sp,
                ),
                textStyle: GoogleFonts.content(
                  fontWeight: FontWeight.w400,
                  color: ConstColors.darkGrey,
                  fontSize: 16.sp,
                ),
                controller: controller.otherConditionController.value,
                validator: controller.validateOther,
                keyoardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z0-9@#£_&-+.()\$/*":;!?€¥¢^=-]'),
                  ),
                ],
                onChanged: (value) {
                  controller.updateOther(value);
                },
                onSaved: (value) {
                  controller.updateOther(value ?? '');
                },
                // Add the focusNode parameter to allow focusing
                focusNode: otherFocusNode,
                onEditingComplete: () {
                  // When user finishes editing (pressing done/enter), show date picker
                  if (controller
                      .otherConditionController.value.text.isNotEmpty) {
                    controller.showOtherDatePicker();
                  }
                },
              ),
            ),
            // Add a button to select date for the "Other" condition
            Obx(() {
              final otherCondition =
                  controller.conditions.firstWhere((c) => c.name == 'Other');
              // Only show the button if text has been entered
              if (controller.otherConditionController.value.text.isNotEmpty) {
                return Column(
                  children: [
                    // Show selected date if it's been confirmed
                    if (otherCondition.dateConfirmed.value &&
                        otherCondition.conditionFromDate.value != null)
                      Padding(
                        padding:
                            EdgeInsets.only(left: 35.w, right: 15.w, top: 5.h),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: ConstColors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16.sp,
                                color: ConstColors.blue,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Date: ${controller.dateFormat.format(otherCondition.conditionFromDate.value!)}',
                                style: getTextTheme(
                                  color: ConstColors.darkGrey,
                                  fontSize: 14.sp,
                                ).bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Date selection button
                    Padding(
                      padding:
                          EdgeInsets.only(left: 35.w, right: 15.w, top: 5.h),
                      child: InkWell(
                        onTap: () {
                          controller.showOtherDatePicker();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: ConstColors.buttonColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16.sp,
                                color: ConstColors.buttonColor,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                otherCondition.dateConfirmed.value
                                    ? 'Change Date'
                                    : 'Select Date',
                                style: getTextTheme(
                                  color: ConstColors.buttonColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ).bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: ConstantButton(
        height: 45.h,
        horiPadding: 15.w,
        vertiPadding: 40.h,
        press: () {
          // Proceed to next page if at least one condition is selected
          if (controller.getSelectedConditions().isNotEmpty) {
            controller.goToNextPage();
          } else {
            // Show error message if no conditions selected
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              const SnackBar(
                content: Text('Please select at least one condition'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        text: "Next",
        borderRadius: 8.sp,
        color: ConstColors.buttonColor,
        bordercolor: ConstColors.buttonColor,
        style: getTextTheme(
          fontWeight: FontWeight.w500,
        ).bodyMedium,
      ),
    );
  }
}
