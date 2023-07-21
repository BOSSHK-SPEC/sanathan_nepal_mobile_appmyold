import 'package:flutter/material.dart';

class GradientElevatedButton extends StatelessWidget {
  final double buttonHeight;
  final double buttonWidth;
  final String buttonText;

  GradientElevatedButton({required this.buttonHeight, required this.buttonWidth, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight,
      width: buttonWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00AEEF), Color(0xFF0072BC)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
