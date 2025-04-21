import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeveritySelector extends StatelessWidget {
  final String symptomName;
  final String selectedSeverity;
  final Function(String) onSeverityChanged;

  const SeveritySelector({
    Key? key,
    required this.symptomName,
    required this.selectedSeverity,
    required this.onSeverityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          symptomName,
          style: getTextTheme(
            color: ConstColors.darkGrey,
            fontSize: 16.sp,
          ).bodyMedium,
        ),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSeverityOption('None', ConstColors.green),
              _buildSeverityOption('Mild', ConstColors.purp),
              _buildSeverityOption('Moderate', ConstColors.orange),
              _buildSeverityOption('Severe', ConstColors.red),
            ],
          ),
        ),
        SizedBox(height: 3.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSeverityRadio('None'),
              _buildSeverityRadio('Mild'),
              _buildSeverityRadio('Moderate'),
              _buildSeverityRadio('Severe'),
            ],
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  Widget _buildSeverityOption(String severity, Color color) {
    return Container(
      width: 70.w,
      height: 24.h,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.sp),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          severity,
          style: getTextTheme(
            color: ConstColors.white,
            fontSize: 10.sp,
          ).bodyMedium,
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ),
    );
  }

  Widget _buildSeverityRadio(String severity) {
    final isSelected = selectedSeverity == severity;

    return Container(
      width: 70.w,
      height: 24.h,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () => onSeverityChanged(severity),
        child: Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? ConstColors.primary
                  : ConstColors.darkGrey.withOpacity(0.3),
              width: 1.5.sp,
            ),
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ConstColors.primary,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
