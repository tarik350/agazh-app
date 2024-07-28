import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';

class AppConfig {
  static final EdgeInsets insideContainerPadding =
      EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w, bottom: 30.h);
  static final EdgeInsets insideContainerTitlePadding =
      EdgeInsets.only(bottom: 40.h, left: 20.w, right: 20.w);
  static BoxDecoration getInsideScreenDecoration(Color? color) {
    return BoxDecoration(
        color: color ?? AppColors.whiteColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.r), topLeft: Radius.circular(30.r)));
  }
}
