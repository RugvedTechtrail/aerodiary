import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'const_colors.dart';

TextTheme getTextTheme(
    {Color? color, double? fontSize, FontWeight? fontWeight}) {
  return TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? ConstColors.buttonColor,
      fontSize: fontSize ?? 22.sp,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.buttonColor,
      fontSize: fontSize ?? 18.sp,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: color ?? ConstColors.buttonColor,
      fontSize: fontSize ?? 16.sp,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      color: color ?? ConstColors.white,
      fontSize: 18.sp,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      color: color ?? ConstColors.white,
      fontSize: 16.sp,
    ),
    bodySmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      color: color ?? ConstColors.white,
      fontSize: 14.sp,
    ),
    titleLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.white,
      fontSize: 24.sp,
    ),
    titleMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.white,
      fontSize: 20.sp,
    ),
    titleSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.white,
      fontSize: 14.sp,
    ),
    displayLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.black,
      fontSize: 16.sp,
    ),
    displayMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.w500,
        color: color ?? ConstColors.black,
        fontSize: 14.sp),
    displaySmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: color ?? ConstColors.black,
    ),
    labelSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 10.sp,
      color: ConstColors.white,
    ),
    labelMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: color ?? ConstColors.white,
    ),
    labelLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
      color: color ?? ConstColors.white,
    ),
  );
}
