import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 12.0,
          ),
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}