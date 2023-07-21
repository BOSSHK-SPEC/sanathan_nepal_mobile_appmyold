/*
import 'package:flutter/material.dart';

class BorderedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double fontSize;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;

  const BorderedButton({
    required this.onPressed,
    required this.label,
    this.fontSize = 12.0,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.borderWidth = 2.0,
    this.borderRadius = 8.0,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provider.dart';

class BorderedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;
  final double width;
  final double height;
  final String text;

  const BorderedButton({
    super.key,
    required this.onPressed,
    required this.borderColor,
    required this.textColor,
    required this.width,
    required this.height,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.zero,
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: borderColor),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(textColor),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 8),
          ),
        ),
      ),
    );
  }
}
