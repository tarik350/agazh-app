import 'package:flutter/material.dart';
import 'package:mobile_app/config/constants/app_colors.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;

  const ProfileTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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
          fillColor: AppColors.primaryColor.withOpacity(.1),
          filled: true,
          // hintText: hintText,
          // errorText: errorText,
          labelText: labelText,
          hintStyle: TextStyle(color: Colors.grey.shade500)),

      // decoration: InputDecoration(
      // ),
    );
  }
}
