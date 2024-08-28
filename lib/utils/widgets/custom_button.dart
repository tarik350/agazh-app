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
          .copyWith(backgroundColor:
              MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return backgroundColor.withOpacity(.7);
        } else {
          return backgroundColor;
        }
      })).copyWith(),
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: padding ?? 20.0,
        ),
        child: Center(
          child: Text(
            lable,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
