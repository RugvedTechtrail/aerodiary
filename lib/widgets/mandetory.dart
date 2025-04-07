import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MandatoryText extends StatelessWidget {
  const MandatoryText(
      {super.key, required this.title, required this.mandatory});
  final String title;
  final bool mandatory;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTextTheme().bodySmall,
        ),
        mandatory == true
            ? Icon(Icons.star_outlined, color: ConstColors.red, size: 10.sp)
            : const SizedBox(),
        Text(
          " :",
          style: getTextTheme().bodySmall,
        ),
      ],
    );
  }
}
