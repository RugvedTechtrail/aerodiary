import 'package:flutter/material.dart';

class ConstWidget {
  static Widget contText(String text,
      {TextStyle? style, TextAlign? textAlign}) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
    );
  }
}
