import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/config/constants/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(dynamic) onChanged;
  final String keyString;
  final String? errorText;
  final TextInputType inputType;
  final String? initialValue;
  final Widget? suffix;
  final int? maxLines;
  final bool enabled;

  const CustomTextfield(
      {super.key,
      this.initialValue,
      this.maxLines,
      required this.hintText,
      required this.obscureText,
      required this.onChanged,
      required this.keyString,
      required this.inputType,
      required this.errorText,
      this.suffix,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: initialValue,
      obscureText: obscureText,
      key: Key(keyString),
      onChanged: onChanged,
      enabled: enabled, // Control the enabled state
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(fontWeight: FontWeight.w300),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: enabled
              ? AppColors.primaryColor.withOpacity(.1)
              : Colors.black.withOpacity(.3),
          filled: true,
          hintText: hintText.tr(),
          errorMaxLines: 3,
          errorText: errorText?.tr(),
          hintStyle:
              TextStyle(color: enabled ? Colors.grey.shade500 : Colors.white)),
    );
  }
}
