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
    return Obx(() {
      final otherCondition =
          controller.conditions.firstWhere((c) => c.name == 'Other');

      if (controller.showOtherTextField.value) {
        // If "Other" is selected and has date confirmed, show just the condition name and edit button
        if (otherCondition.dateConfirmed.value &&
            otherCondition.conditionFromDate.value != null) {
          return Padding(
            padding: EdgeInsets.only(left: 35.w, right: 15.w, top: 10.h),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              decoration: BoxDecoration(
                color: ConstColors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18.sp,
                    color: ConstColors.blue,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Other: ${controller.otherConditionController.value.text}',
                      style: getTextTheme(
                        color: ConstColors.darkGrey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ).bodyMedium,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.showOtherDatePicker();
                    },
                    child: Icon(
                      Icons.edit,
                      size: 18.sp,
                      color: ConstColors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // If "Other" is selected but no date has been confirmed yet, show nothing
        // The dialog will be shown automatically when the condition is selected
        return const SizedBox.shrink();
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
