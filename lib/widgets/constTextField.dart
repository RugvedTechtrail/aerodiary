import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/mandetory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstTextField extends StatelessWidget {
  // final double width;
  // final double height;
  final String customText;
  final TextEditingController controller;
  final TextInputType? keyoardType;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool obsercureText;
  final int minline;
  final int maxline;
  final Widget iconss;
  final String? mandatoryTitle;
  final void Function(String?)? onSaved;
  final bool? mandatory;
  final double? fontSize;
  final Color? color;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final AutovalidateMode? autovalidateMode;
  const ConstTextField(
      {super.key,

      // required this.width,
      this.fontSize,
      this.color,
      required this.customText,
      required this.controller,
      required this.validator,
      required this.inputFormatters,
      this.readOnly = false,
      this.mandatory,
      this.obsercureText = false,
      this.minline = 1,
      this.maxline = 5,
      this.iconss = const SizedBox(),
      required this.onChanged,
      required this.onSaved,
      this.keyoardType,
      this.textStyle,
      this.hintStyle,
      this.autovalidateMode,
      this.mandatoryTitle = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            obscureText: obsercureText,
            inputFormatters: inputFormatters,
            keyboardType: keyoardType ?? TextInputType.emailAddress,
            readOnly: readOnly,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            autovalidateMode: autovalidateMode,
            style: textStyle ?? getTextTheme().headlineSmall,
            cursorColor: ConstColors.black,
            maxLines: maxline,
            minLines: minline,
            decoration: InputDecoration(
              fillColor:
                  readOnly == true ? ConstColors.white : ConstColors.white,
              hintText: customText,

              suffixIcon: iconss,
              hintStyle: hintStyle ??
                  GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    color: ConstColors.black,
                    fontSize: 12.sp,
                  ),

              errorStyle: TextStyle(
                height: 0.sp,
                color: color ?? ConstColors.red,
                fontSize: fontSize ?? 12.sp,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
              filled: true,
              //fillColor: ConstColors.backgroundColor,
              //isDense: false,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                //borderRadius: BorderRadius.all(Radius.circular(20)),
                borderRadius: BorderRadius.circular(10),

                borderSide: BorderSide(width: 1.sp, color: ConstColors.white),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 1.sp, color: ConstColors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 1.sp, color: ConstColors.white),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 1.sp, color: ConstColors.white),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 1.sp, color: ConstColors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                //borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 2.sp, color: ConstColors.red),
              ),
            ),
            onChanged: onChanged,
            validator: validator,
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }
}
