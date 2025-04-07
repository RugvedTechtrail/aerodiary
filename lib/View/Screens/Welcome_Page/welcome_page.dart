import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/widgets/constText.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.primary,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                ConstWidget.contText(
                  "Welcome",
                  style: GoogleFonts.content(
                    fontWeight: FontWeight.w400,
                    color: ConstColors.buttonColor,
                    fontSize: 22.sp,
                  ),
                ),
                ConstWidget.contText(
                  "To",
                  style: GoogleFonts.content(
                    fontWeight: FontWeight.w400,
                    color: ConstColors.buttonColor,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                ConstWidget.contText(
                  "AeroDiary",
                  style: GoogleFonts.content(
                    fontWeight: FontWeight.w400,
                    color: ConstColors.buttonColor,
                    fontSize: 36.sp,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ConstantButton(
                  press: () {
                    Get.toNamed('/patient_screen');
                  },
                  text: 'Register as Patient',
                  color: ConstColors.buttonColor,
                  bordercolor: ConstColors.buttonColor,
                  style: GoogleFonts.content(
                    fontWeight: FontWeight.w300,
                    color: ConstColors.white,
                    fontSize: 18.sp,
                  ),
                  height: 35.h,
                  width: 320.w,
                  vertiPadding: 30.h,
                ),
                ConstantButton(
                  press: () {
                    Get.toNamed('/welcome_page');
                  },
                  text: 'Register as Caregiver',
                  color: ConstColors.buttonColor,
                  bordercolor: ConstColors.buttonColor,
                  style: GoogleFonts.content(
                    fontWeight: FontWeight.w300,
                    color: ConstColors.white,
                    fontSize: 18.sp,
                  ),
                  height: 35.h,
                  width: 320.w,
                  vertiPadding: 30.h,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
