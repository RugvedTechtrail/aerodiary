import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/constDatePicker.dart';
import 'package:aerodiary/widgets/constTextField.dart';
import 'package:aerodiary/widgets/const_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ConditionDatePickerDialog extends StatelessWidget {
  final String title;
  final String message;
  final TextEditingController dateController;
  final Function(String) onDateChanged;
  final Function() onDone;
  final Function() onCancel;
  final DateTime? initialDate;
  final GlobalKey<FormState> formKey;
  final bool isOtherCondition;
  final TextEditingController? otherConditionController;
  final Function(String)? onOtherConditionChanged;

  const ConditionDatePickerDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.dateController,
    required this.onDateChanged,
    required this.onDone,
    required this.onCancel,
    required this.formKey,
    this.initialDate,
    this.isOtherCondition = false,
    this.otherConditionController,
    this.onOtherConditionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dialog Header
            Container(
              decoration: const BoxDecoration(
                color: ConstColors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
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
                        Expanded(
                          child: Text(
                            title,
                            style: getTextTheme().bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: onCancel,
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),

            // Dialog Content
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Message text
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                    child: Text(
                      message,
                      style: getTextTheme(
                        color: ConstColors.darkGrey,
                      ).bodyMedium,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),

                  // Text field for "Other" condition if needed
                  if (isOtherCondition && otherConditionController != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: ConstTextField(
                        iconss: const SizedBox(),
                        customText: 'Type other condition',
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: ConstColors.grey,
                          fontSize: 16.sp,
                        ),
                        textStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: ConstColors.darkGrey,
                          fontSize: 16.sp,
                        ),
                        controller: otherConditionController!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please specify the condition';
                          }
                          return null;
                        },
                        keyoardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9@#£_&-+.()\$/*":;!?€¥¢^=-]'),
                          ),
                        ],
                        onChanged: (value) {
                          if (onOtherConditionChanged != null) {
                            onOtherConditionChanged!(value);
                          }
                        },
                        onSaved: (value) {
                          if (onOtherConditionChanged != null &&
                              value != null) {
                            onOtherConditionChanged!(value);
                          }
                        },
                        // Auto-focus when dialog opens
                        focusNode: FocusNode()..requestFocus(),
                      ),
                    ),

                  // Date picker
                  ConstYearPicker(
                    controller: dateController,
                    hintText: 'Select Date',
                    textStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: ConstColors.darkGrey,
                      fontSize: 16.sp,
                    ),
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      color: ConstColors.grey,
                      fontSize: 16.sp,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                    onChanged: onDateChanged,
                    onSaved: (p0) {},
                    iconColor: ConstColors.darkGrey,
                  ),

                  // Done button
                  ConstantButton(
                    height: 45.h,
                    horiPadding: 15.w,
                    vertiPadding: 40.h,
                    press: onDone,
                    text: "Done",
                    borderRadius: 8.sp,
                    color: ConstColors.buttonColor,
                    bordercolor: ConstColors.buttonColor,
                    style: getTextTheme(
                      fontWeight: FontWeight.w500,
                    ).bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
