import 'dart:developer';

import 'package:aerodiary/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../constants/custom_textstyle.dart';

class ConstTimePicker extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController scondcontroller;
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final bool? readOnly;
  final bool toTime;
  String? date;
  double? width;
  DateTime? finalDate;

  ConstTimePicker(
      {super.key,
      required this.controller,
      required this.onChanged,
      required this.validator,
      this.toTime = false,
      this.finalDate,
      this.width,
      this.readOnly,
      required this.date,
      required this.scondcontroller});

  @override
  ConstTimePickerState createState() => ConstTimePickerState();
}

class ConstTimePickerState extends State<ConstTimePicker> {
  Future<void> _showtime(BuildContext context) async {
    log("the value of widget.pickDate! is ${widget.controller.text}");
    log("the value of widget.pickDate! is ${widget.scondcontroller.text}");
    log("the value of widget.pickDate! is ${widget.toTime}");
    TimeOfDay initialDate = TimeOfDay.now();
    // TimeOfDay initialDate1= TimeOfDay.fromDateTime(DateFormat.jm().parse(widget.scondcontroller.text));
    // log("the value of widget.pickDate! is $initialDate1");
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialDate,
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: ConstColors.black,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        log("widget date is ${widget.date}");
        date = widget.date!.isNotEmpty
            ? DateFormat('yyyy-MM-dd').parse(widget.date!)
            : DateTime.now();
        log("formated date is $date");
        //String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(dateTime);
        DateTime? dateTime;
        DateTime now = DateTime.now();
        widget.date != null
            ? dateTime = DateTime(
                date!.year, date!.month, date!.day, picked.hour, picked.minute)
            : DateTime(
                now.year, now.month, now.day, picked.hour, picked.minute);
        // widget.controller.text = DateFormat("hh:mm a").format(dateTime!);
        widget.controller.text = DateFormat("HH:mm:ss a").format(dateTime!);
        // widget.toTime == false
        //     ? widget.scondcontroller.text = DateFormat("hh:mm a")
        //         .format(dateTime.add(const Duration(hours: 1)))
        //     : DateFormat("hh:mm a").format(dateTime);
        widget.toTime == false
            ? widget.scondcontroller.text = DateFormat("HH:mm:ss a")
                .format(dateTime.add(const Duration(hours: 1)))
            : DateFormat("HH:mm:ss a").format(dateTime);
        widget.finalDate = dateTime;
      });
      log('Picked time is :$picked');
      log('Picked time is :$picked');
      log("dateTime is ${widget.finalDate}");
    }
  }

  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showtime(context),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 5),
        width: widget.width ?? 150.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ConstColors.black,
            border: Border.all(color: ConstColors.darkGrey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                readOnly: widget.readOnly ?? false,
                controller: widget.controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: getTextTheme().headlineSmall,
                  border: InputBorder.none,
                  counterText: "",
                ),
                style: getTextTheme().headlineSmall,
                validator: widget.validator,
                onChanged: widget.onChanged,
                maxLength: 4,
                enabled: false,
                onTap: () => _showtime(context),
              ),
            ),
            IconButton(
              onPressed: () => _showtime(context),
              icon: Icon(
                Icons.schedule,
                size: 20.sp,
                color: ConstColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
