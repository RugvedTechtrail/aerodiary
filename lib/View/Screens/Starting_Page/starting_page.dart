import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constText.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstColors.primary,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/start.png',
                  width: double.infinity,
                  height: 580.h,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  left: 100.w,
                  top: 70.h,
                  child: ConstWidget.contText(
                    "AeroDiary",
                    style: GoogleFonts.content(
                      fontWeight: FontWeight.w400,
                      color: ConstColors.buttonColor,
                      fontSize: 36.sp,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstWidget.contText(
                    'For Daily Asthama Care',
                    style: getTextTheme().bodyMedium,
                  ),
                  SizedBox(height: 10.h),
                  ConstWidget.contText(
                    'Get to know your asthma condition by your daily asthma records ',
                    style: getTextTheme().bodySmall,
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: ConstantButton(
                      press: () {
                        Get.toNamed('/welcome_page');
                      },
                      text: 'Get Started',
                      color: ConstColors.buttonColor,
                      bordercolor: ConstColors.buttonColor,
                      style: GoogleFonts.content(
                        fontWeight: FontWeight.w300,
                        color: ConstColors.white,
                        fontSize: 18.sp,
                      ),
                      height: 35.h,
                      width: 320.w,
                      vertiPadding: 25.h,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
