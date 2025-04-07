import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/const_colors.dart';
import '../../constants/custom_textstyle.dart';

class ConstantButton extends StatelessWidget {
  const ConstantButton(
      {super.key,
      required this.press,
      required this.text,
      this.width,
      this.style,
      this.color,
      this.borderRadius,
      this.horiPadding,
      this.vertiPadding,
      this.bordercolor,
      this.height = 40});
  final VoidCallback? press;
  final String text;
  final color;
  final bordercolor;
  final width;
  final TextStyle? style;
  final double height;
  final double? borderRadius;
  final double? horiPadding;
  final double? vertiPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horiPadding ?? 0, vertical: vertiPadding ?? 0),
      child: SizedBox(
        height: height,
        width: width ?? 360.w,
        child: ElevatedButton(
          onPressed: press,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? ConstColors.white,
            side: BorderSide(color: bordercolor ?? ConstColors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 0),
          ),
          child: FittedBox(
            child: Text(
              text,
              style: style ?? getTextTheme().displaySmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
