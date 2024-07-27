import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  // final controller;
  final String hintText;
  final bool obscureText;
  final Function(String) onChanged;
  final String keyString;
  final String? errorText;
  final TextInputType inputType;
  final String? initialValue;

  const CustomTextfield({
    super.key,
    // required this.controller,
    this.initialValue,
    required this.hintText,
    required this.obscureText,
    required this.onChanged,
    required this.keyString,
    required this.inputType,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      key: Key(keyString),
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(fontWeight: FontWeight.w300),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          errorText: errorText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}
