import 'package:aerodiary/constants/const_colors.dart';
import 'package:aerodiary/constants/custom_textstyle.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropCustom extends StatefulWidget {
  // final double width;
  // final double height;

  final String valText;
  final TextEditingController? search;
  final String title;
  final String? hint;
  final List<String> option;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool mandatory;
  final void Function(String?)? onChanged; // Callback for value change
  final void Function(String?)? onSave; // Callback for saving value
  final String? selectedValue;
  final double? padingTop;
  final double? contentPadingVert;

  const DropCustom(
      {super.key,
      required this.validator,
      this.readOnly = false,
      this.mandatory = false,
      required this.title,
      required this.option,
      required this.valText,
      this.onChanged,
      this.onSave,
      this.selectedValue,
      this.padingTop,
      this.hint,
      this.contentPadingVert,
      this.search});

  @override
  State<DropCustom> createState() => _DropCustomState();
}

class _DropCustomState extends State<DropCustom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
                left: 5.w, top: widget.padingTop ?? 8.h, bottom: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.mandatory == false
                    ? Text(
                        "${widget.title} :",
                        style: getTextTheme().bodySmall,
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.title}",
                            style: getTextTheme().bodySmall,
                          ),
                          Icon(Icons.star_outlined,
                              color: ConstColors.red, size: 10.sp),
                          Text(
                            ":",
                            style: getTextTheme().bodySmall,
                          ),
                        ],
                      ),
              ],
            )),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField2<String>(
            dropdownSearchData: DropdownSearchData<String>(
              searchController: widget.search,
            ),
            isExpanded: true,
            style: getTextTheme().headlineSmall,
            items: widget.option.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                enabled: true,
                child: Container(
                  width: 250.w,
                  child: Text(
                    item,
                    style: getTextTheme().headlineSmall,
                  ),
                ),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
                return widget.valText;
              }
              return null;
            },
            hint: Text(
              "${widget.hint}",
              style: getTextTheme().headlineSmall,
            ),
            // onSaved: (value) {
            //   selectedValue = value.toString();
            // },
            // onChanged: (value) {
            //   setState(() {
            //     selectedValue=value;
            //     log("value is $selectedValue");
            //   });
            // },
            onChanged: widget.onChanged,
            onSaved: widget.onSave,
            value: widget.selectedValue,
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: ConstColors.black,
              ),
              iconSize: 25,
            ),
            decoration: InputDecoration(
              // Add Horizontal padding using menuItemStyleData.padding so it matches
              // the menu padding when button's width is not specified.
              contentPadding: EdgeInsets.only(
                  top: widget.contentPadingVert ?? 0,
                  right: 10,
                  bottom: widget.contentPadingVert ?? 0),
              //errorText: widget.valText,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstColors.textColor),
                  borderRadius: BorderRadius.circular(15)),
              focusColor: ConstColors.black,
              fillColor: ConstColors.red,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstColors.darkGrey),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstColors.primary),
                  borderRadius: BorderRadius.circular(15)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstColors.red),
                  borderRadius: BorderRadius.circular(15)),
              errorStyle: TextStyle(
                height: 0.sp,
                color: ConstColors.red,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
              // Add more decoration..
            ),
            /* buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                color: ConstColors.textback,
              ),
            ),*/
            dropdownStyleData: DropdownStyleData(
              //padding: EdgeInsets.symmetric(vertical: 15.h),
              decoration: BoxDecoration(
                color: ConstColors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              //height: 30.h,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}
