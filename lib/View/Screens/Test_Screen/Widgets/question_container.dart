import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionContainer extends StatelessWidget {
  final String questionNumber;
  final int totalQuestions;
  final String questionText;
  final Widget optionsWidget;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool isLastQuestion;

  const QuestionContainer({
    Key? key,
    required this.questionNumber,
    required this.totalQuestions,
    required this.questionText,
    required this.optionsWidget,
    required this.onNext,
    this.onBack,
    this.isLastQuestion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: ConstColors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with questionnaire info and static back arrow
          Row(
            children: [
              Icon(
                Icons.arrow_left,
                color: ConstColors.primary,
                size: 35.sp,
              ),
              SizedBox(width: 5.w),
              Text(
                'Questionnaire, ${DateTime.now().day}${_getDaySuffix(DateTime.now().day)} ${_getMonth(DateTime.now().month)} ${DateTime.now().year}, ${_formatTime(DateTime.now())}',
                style: TextStyle(
                  color: ConstColors.buttonColor,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Question number and text
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: ConstColors.buttonColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.sp),
                topRight: Radius.circular(10.sp),
              ),
            ),
            child: Text(
              'Question $questionNumber / $totalQuestions',
              style: getTextTheme(
                color: ConstColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ).bodyLarge,
            ),
          ),

          // Question text and options in the same container
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: ConstColors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.sp),
                bottomRight: Radius.circular(10.sp),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question text
                Text(
                  questionText,
                  style: getTextTheme(
                    color: ConstColors.darkGrey,
                    fontSize: 16.sp,
                  ).bodyMedium,
                ),

                SizedBox(height: 15.h),

                // Options widget right below the question
                optionsWidget,
              ],
            ),
          ),

          Spacer(),

          // Back button (if it's not the first question)
          if (onBack != null)
            Container(
              width: double.infinity,
              height: 50.h,
              margin: EdgeInsets.only(bottom: 10.h),
              child: ElevatedButton(
                onPressed: onBack,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                ),
                child: Text(
                  'Back',
                  style: getTextTheme(
                    color: ConstColors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ).bodyLarge,
                ),
              ),
            ),

          // Next/Done button
          Container(
            width: double.infinity,
            height: 50.h,
            margin: EdgeInsets.only(bottom: 30.h),
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstColors.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.sp),
                ),
              ),
              child: Text(
                isLastQuestion ? 'Done' : 'Next',
                style: getTextTheme(
                  color: ConstColors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ).bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
