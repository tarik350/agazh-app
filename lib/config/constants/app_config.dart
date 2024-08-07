import 'package:cached_network_image/cached_network_image.dart';
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

  static void getMassenger(BuildContext context, String? message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message ?? "Unknown error occured")),
      );
  }

  static Widget getProgressIndicatorNormal({Color? color}) {
    return Center(
        child: SizedBox(
            width: 10.0.w,
            height: 10.0.h,
            child: CircularProgressIndicator(
              color: color ?? AppColors.primaryColor,
            )));
  }

  static Widget getProgresIndicator(
      DownloadProgress downloadProgress, Color? color) {
    return Center(
        child: SizedBox(
            width: 10.0.w,
            height: 10.0.h,
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: color ?? AppColors.primaryColor,
            )));
  }

  static String toSnakeCase(String input) {
    input = input.trim();
    String snakeCase = input.replaceAll(RegExp(r'\s+'), '_').toLowerCase();

    return snakeCase;
  }
}
