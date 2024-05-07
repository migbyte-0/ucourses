import 'package:flutter/material.dart';
import 'package:ucourses/core/constants/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final IconData? prefixIcon;
  final IconData? suffixIconData;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final VoidCallback? onClearButtonPressed;
  final String labelText;
  final bool obscureText;

  const CustomInputField({
    super.key,
    this.prefixIcon,
    this.suffixIconData,
    this.validator,
    this.controller,
    this.onClearButtonPressed,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: labelText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.deepPurple)
            : null,
        suffixIcon: suffixIconData != null
            ? IconButton(
                icon: Icon(suffixIconData),
                onPressed: onClearButtonPressed,
              )
            : null,
      ),
    );
  }
}
