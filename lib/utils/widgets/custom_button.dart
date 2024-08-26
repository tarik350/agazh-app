import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String lable;
  final Color backgroundColor;
  final double? padding;

  const CustomButton(
      {super.key,
      required this.onTap,
      required this.lable,
      this.padding,
      this.backgroundColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))
          .copyWith(backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return backgroundColor.withOpacity(.3);
          } else {
            return backgroundColor;
          }
        },
      ), foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.black.withOpacity(.3);
          } else {
            return Colors.white;
          }
        },
      )).copyWith(),
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: padding ?? 20.0,
        ),
        child: Center(
          child: Text(
            lable,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
