import 'package:flutter/material.dart';
class TextStyles {
  static TextStyle heading({Color? color}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: color,
  );

  static TextStyle subheading({Color? color}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle body({Color? color}) => TextStyle(
    fontSize: 16,
    color: color,
  );

  static TextStyle smallBody({Color? color}) => TextStyle(
    fontSize: 12,
    color: color,
    fontWeight: FontWeight.w500

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
