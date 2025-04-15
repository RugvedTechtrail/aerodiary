import 'package:aerodiary/View/Screens/Home_Page/Controller/home_patient_controller.dart';
import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConditionItemWidget extends StatelessWidget {
  final PatientHistoryController controller;
  final int index;

  const ConditionItemWidget({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: InkWell(
        onTap: () => controller.toggleCondition(index),
        child: Row(
          children: [
            Obx(() {
              final condition = controller.conditions[index];
              return Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: condition.isSelected.value
                        ? const Color(0xFF4BA8A5)
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                ),
                child: condition.isSelected.value
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4BA8A5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              );
            }),
            SizedBox(width: 10.w),
            Obx(() {
              final condition = controller.conditions[index];
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      condition.name,
                      style: getTextTheme(
                        color: ConstColors.darkGrey,
                      ).bodyMedium,
                    ),
                    if (condition.isSelected.value)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: condition.conditionFromDate.value != null &&
                                condition.dateConfirmed.value
                            ? Text(
                                'Since: ${controller.dateFormat.format(condition.conditionFromDate.value!)}',
                                style: getTextTheme(
                                  color: ConstColors.darkGrey.withOpacity(0.7),
                                  fontSize: 12.sp,
                                ).bodySmall,
                              )
                            : Text(
                                'Select date',
                                style: getTextTheme(
                                  color: ConstColors.grey,
                                  fontSize: 12.sp,
                                ).bodySmall,
                              ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
