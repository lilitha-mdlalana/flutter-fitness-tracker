import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color fillColor;

  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.enabledBorderColor,
      required this.focusedBorderColor,
      required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enabledBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor)),
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
