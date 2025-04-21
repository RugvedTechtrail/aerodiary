import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionSelector extends StatelessWidget {
  final bool isSelected;
  final String optionText;
  final VoidCallback onTap;

  const OptionSelector({
    Key? key,
    required this.isSelected,
    required this.optionText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Container(
              width: 22.w,
              height: 22.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? ConstColors.primary
                      : ConstColors.darkGrey.withOpacity(0.3),
                  width: 2.sp,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ConstColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 10.w),
            Text(
              optionText,
              style: getTextTheme(
                color: ConstColors.darkGrey,
                fontSize: 14.sp,
              ).bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
