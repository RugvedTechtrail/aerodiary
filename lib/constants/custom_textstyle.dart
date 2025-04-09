import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'const_colors.dart';

TextTheme getTextTheme(
    {Color? color, double? fontSize, FontWeight? fontWeight}) {
  return TextTheme(
    headlineLarge: GoogleFonts.content(
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? ConstColors.buttonColor,
      fontSize: fontSize ?? 22.sp,
    ),
    headlineMedium: GoogleFonts.content(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.buttonColor,
      fontSize: fontSize ?? 18.sp,
    ),
    headlineSmall: GoogleFonts.content(
      fontWeight: FontWeight.w400,
      color: color ?? ConstColors.buttonColor,
      fontSize: fontSize ?? 16.sp,
    ),
    bodyLarge: GoogleFonts.content(
      fontWeight: FontWeight.normal,
      color: color ?? ConstColors.white,
      fontSize: 18.sp,
    ),
    bodyMedium: GoogleFonts.content(
      fontWeight: FontWeight.normal,
      color: color ?? ConstColors.white,
      fontSize: 16.sp,
    ),
    bodySmall: GoogleFonts.content(
      fontWeight: FontWeight.w400,
      color: color ?? ConstColors.white,
      fontSize: 14.sp,
    ),
    titleLarge: GoogleFonts.content(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.white,
      fontSize: 24.sp,
    ),
    titleMedium: GoogleFonts.content(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.white,
      fontSize: 20.sp,
    ),
    titleSmall: GoogleFonts.content(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.white,
      fontSize: 14.sp,
    ),
    displayLarge: GoogleFonts.content(
      fontWeight: FontWeight.w500,
      color: color ?? ConstColors.black,
      fontSize: 16.sp,
    ),
    displayMedium: GoogleFonts.content(
        fontWeight: FontWeight.w500,
        color: color ?? ConstColors.black,
        fontSize: 14.sp),
    displaySmall: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: color ?? ConstColors.black,
    ),
    labelSmall: GoogleFonts.content(
      fontWeight: FontWeight.w500,
      fontSize: 10.sp,
      color: ConstColors.white,
    ),
    labelMedium: GoogleFonts.content(
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: color ?? ConstColors.white,
    ),
    labelLarge: GoogleFonts.content(
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
      color: color ?? ConstColors.white,
    ),
  );
}
