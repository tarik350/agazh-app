import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants/app_colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double width;
  final double height;
  final double strokeWidth;
  final Color color;
  const CustomProgressIndicator(
      {super.key,
      this.height = 12,
      this.width = 12,
      this.strokeWidth = 4,
      this.color = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: height,
      height: width,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
