import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'const_colors.dart';

TextTheme getTextTheme() {
  return TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w700,
      color: ConstColors.white,
      fontSize: 16.sp,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: ConstColors.white,
      fontSize: 13.sp,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: ConstColors.white,
      fontSize: 12.sp,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: ConstColors.white,
      fontSize: 18.sp,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      color: ConstColors.white,
      fontSize: 16.sp,
    ),
    bodySmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: ConstColors.white,
      fontSize: 12.sp,
    ),
    titleLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: ConstColors.white,
      fontSize: 24.sp,
    ),
    titleMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: ConstColors.white,
      fontSize: 20.sp,
    ),
    titleSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: ConstColors.white,
      fontSize: 14.sp,
    ),
    displayLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: ConstColors.white,
      fontSize: 16.sp,
    ),
    displayMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.w500, color: ConstColors.white, fontSize: 14.sp),
    displaySmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: ConstColors.primary,
    ),
    labelSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 10.sp,
      color: ConstColors.white,
    ),
    labelMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: ConstColors.white,
    ),
    labelLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
      color: ConstColors.white,
    ),
  );
}
