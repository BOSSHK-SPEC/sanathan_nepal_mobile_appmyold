import 'package:flutter/material.dart';
class TextStyles {
  static TextStyle heading({Color? color}) => TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: color,
  );

  static TextStyle subheading({Color? color}) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle body({Color? color,FontWeight? fontweight}) => TextStyle(
    fontSize: 16,
    color: color,
    fontWeight: fontweight,

  );

  static TextStyle smallBody({Color? color}) => TextStyle(
    fontSize: 12,
    color: color,
  );
  static TextStyle smallBody2({Color? color}) => TextStyle(
    fontSize: 10,
    color: color,
  );
  static TextStyle smallBody3({Color? color}) => TextStyle(
    fontSize: 8,
    color: color,
  );
}
