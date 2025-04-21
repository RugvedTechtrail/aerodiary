import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
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
  final Color? iconColor;
  final AutovalidateMode? autovalidateMode;

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
    this.iconColor,
    this.autovalidateMode,
  });

  @override
  ConstYearPickerState createState() => ConstYearPickerState();
}

class ConstYearPickerState extends State<ConstYearPicker> {
  GetStorage box = GetStorage();
  Future<void> _startMonthYear(BuildContext context) async {
    // Explicitly dismiss the keyboard
    FocusManager.instance.primaryFocus?.unfocus();

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
      // Update the text controller
      final formattedDate = DateFormat("yyyy-MM-dd").format(picked);
      setState(() {
        widget.controller.text = formattedDate;
      });

      // Call onChanged to notify parent
      widget.onChanged(formattedDate);

      // If onSaved is provided, call it as well to ensure form state is updated
      if (widget.onSaved != null) {
        widget.onSaved!(formattedDate);
      }

      // Force validation to run immediately to clear error
      if (Form.of(context) != null) {
        Form.of(context)!.validate();
      }
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
              // Dismiss keyboard
              FocusManager.instance.primaryFocus?.unfocus();
              _startMonthYear(context);
            },
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_month_sharp,
                    color: widget.iconColor ?? ConstColors.grey,
                    size: 25.sp,
                  ),
                  onPressed: () {
                    // Dismiss keyboard
                    FocusManager.instance.primaryFocus?.unfocus();
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
              autovalidateMode: widget.autovalidateMode,
              style: widget.textStyle ?? getTextTheme().displaySmall,
              validator: widget.validator,
              onSaved: widget.onSaved,
              enabled: false,
              onTap: () {
                // Dismiss keyboard
                FocusManager.instance.primaryFocus?.unfocus();
                _startMonthYear(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
