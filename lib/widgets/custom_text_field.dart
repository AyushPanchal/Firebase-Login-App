import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  IconData? suffixIcon;
  String? errorText;
  FormFieldValidator? validator;
  TextEditingController? controller;
  VoidCallback? onSuffixIconTap;
  final TextInputType keyboardType;
  final Color fillColor;
  final IconData prefixIcon;
  final String hintText;
  final bool obscureText;
  CustomTextField({
    Key? key,
    this.validator,
    this.errorText,
    this.controller,
    this.onSuffixIconTap,
    this.suffixIcon,
    required this.fillColor,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.left,
      cursorHeight: 20,
      cursorColor: AppColours.componentsColor,
      decoration: InputDecoration(
        errorText: errorText,
        suffixIcon: GestureDetector(
          onTap: onSuffixIconTap,
          child: Icon(
            suffixIcon,
            color: AppColours.componentsColor,
            size: 22,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColours.activeColor.withOpacity(0.5),
        ),
        fillColor: fillColor,
        filled: true,
        prefixIcon: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              prefixIcon,
              color: AppColours.activeColor,
            ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
