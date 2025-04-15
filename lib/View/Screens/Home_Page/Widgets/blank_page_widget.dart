import 'package:aerodiary/View/Screens/Home_Page/Controller/home_patient_controller.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BlankPageWidget extends StatelessWidget {
  final PatientHistoryController controller;
  final int pageIndex;
  final bool isSummary;

  const BlankPageWidget({
    Key? key,
    required this.controller,
    required this.pageIndex,
    this.isSummary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          _buildHeader(),

          // Content - Placeholder or summary based on the page
          isSummary ? _buildSummaryContent() : _buildPlaceholderContent(),

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
                  child: Text(
                    (pageIndex + 1).toString(),
                    style: getTextTheme(
                      color: ConstColors.buttonColor,
                      fontWeight: FontWeight.bold,
                    ).bodyMedium,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                isSummary ? 'Summary' : 'Page ${pageIndex + 1}',
                style: getTextTheme().bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderContent() {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64.sp,
              color: ConstColors.buttonColor,
            ),
            SizedBox(height: 16.h),
            Text(
              'Page content will be implemented',
              style: getTextTheme(
                color: ConstColors.darkGrey,
              ).bodyLarge,
            ),
            SizedBox(height: 8.h),
            Text(
              'This is a placeholder for page ${pageIndex + 1}',
              style: getTextTheme(
                color: ConstColors.grey,
              ).bodyMedium,
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryContent() {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary of your selections:',
            style: getTextTheme(
              fontWeight: FontWeight.bold,
            ).titleMedium,
          ),
          SizedBox(height: 16.h),
          Text(
            'Selected conditions:',
            style: getTextTheme(
              fontWeight: FontWeight.w500,
            ).bodyLarge,
          ),
          SizedBox(height: 8.h),
          ...controller.getSelectedConditions().map(
                (condition) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text(
                    '• $condition',
                    style: getTextTheme(
                      color: ConstColors.darkGrey,
                    ).bodyMedium,
                  ),
                ),
              ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.all(16.0.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstantButton(
            press: () {
              controller.goToPreviousPage();
            },
            text: 'Back',
            color: ConstColors.white,
            bordercolor: ConstColors.buttonColor,
            style: GoogleFonts.content(
              fontWeight: FontWeight.w300,
              color: ConstColors.buttonColor,
              fontSize: 16.sp,
            ),
            height: 40.h,
            width: 120.w,
            vertiPadding: 0,
          ),
          ConstantButton(
            press: () {
              if (isSummary) {
                // Submit form if it's the last page
                Get.snackbar(
                  'Success',
                  'Form submitted successfully',
                  backgroundColor: ConstColors.green,
                  colorText: ConstColors.white,
                );
              } else {
                // Go to next page
                controller.goToNextPage();
              }
            },
            text: isSummary ? 'Submit' : 'Next',
            color: ConstColors.buttonColor,
            bordercolor: ConstColors.buttonColor,
            style: GoogleFonts.content(
              fontWeight: FontWeight.w300,
              color: ConstColors.white,
              fontSize: 16.sp,
            ),
            height: 40.h,
            width: 120.w,
            vertiPadding: 0,
          ),
        ],
      ),
    );
  }
}
