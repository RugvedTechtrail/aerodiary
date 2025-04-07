import 'dart:developer';

import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:aerodiary/widgets/mandetory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ConstYearPicker extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController? controller1;

  final Function(String) onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?) validator;
  final String? mandatoryTitle;
  final bool? isSecond;
  final String hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const ConstYearPicker({
    super.key,
    required this.controller,
    this.controller1,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
    this.mandatoryTitle,
    this.isSecond,
    required this.hintText,
    this.textStyle,
    this.hintStyle,
  });

  @override
  ConstYearPickerState createState() => ConstYearPickerState();
}

class ConstYearPickerState extends State<ConstYearPicker> {
  GetStorage box = GetStorage();
  Future<void> _startMonthYear(BuildContext context) async {
    final DateTime now = DateTime.now();
    DateTime? date1 = widget.controller1?.value != null
        ? DateTime.parse(widget.controller1!.text)
        : null;
    DateTime firstDate =
        widget.isSecond == true ? date1! : DateTime(now.year - 24);
    DateTime lastDate = DateTime(now.year, now.month, now.day);
    DateTime initialDate = widget.isSecond == true ? date1! : DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDatePickerMode: DatePickerMode.day,
      builder: (BuildContext context, Widget? child) {
        // log('in date picker of fuel expense');
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: ConstColors.white,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        widget.controller.text = DateFormat("yyyy-MM-dd").format(picked);

        log("widget.controller.text ${widget.controller.text}");
        //log("widget.controller1.text ${widget.controller1?.text}");
      });
      int? empPerId = box.read("empPerId");

      // log("date1 is  $date1");
      // log("picked date  is  $picked");
      // log("widget.isSecond is  ${widget.isSecond}");
      // log('Picked Month: ${picked.month}, Year: ${picked.year}');
      // log("controller value is ${widget.controller.text}");
      // log("controller1 value is ${widget.controller1?.text}");
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   widget.controller.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
  //   widget.controller1?.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _startMonthYear(context);
            },
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_month_sharp,
                    color: ConstColors.darkGrey,
                    size: 25.sp,
                  ),
                  onPressed: () {
                    _startMonthYear(context);
                  },
                ),
                hintText: widget.hintText,
                //labelText: label,
                labelStyle: getTextTheme().bodyMedium,
                fillColor: ConstColors.white,
                filled: true,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: ConstColors.white, width: .09.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: ConstColors.white, width: .09.w),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: ConstColors.white,
                  ),
                ),
                hintStyle: widget.hintStyle ?? getTextTheme().displaySmall,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.h, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: ConstColors.white,
                  ),
                ),
                errorStyle: TextStyle(
                  height: 0.sp,
                  color: ConstColors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: ConstColors.red,
                  ),
                ),
              ),
              style: widget.textStyle ?? getTextTheme().displaySmall,
              validator: widget.validator,
              onSaved: widget.onSaved,
              onChanged: widget.onChanged,
              enabled: false,
              onTap: () => _startMonthYear(context),
            ),
          ),
        ],
      ),
    );
  }
}
