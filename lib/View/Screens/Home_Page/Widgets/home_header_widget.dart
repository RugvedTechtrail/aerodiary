import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const HomeHeaderWidget({
    Key? key,
    this.title = 'Add Patient History',
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15.h,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onBackPressed,
            child: Icon(
              Icons.arrow_left,
              color: ConstColors.primary,
              size: 35.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: getTextTheme(color: ConstColors.primary).headlineMedium,
          ),
        ],
      ),
    );
  }
}
