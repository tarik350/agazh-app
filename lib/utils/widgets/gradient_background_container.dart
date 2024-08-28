import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';

class GradientBackgroundContainer extends StatelessWidget {
  final Widget child;
  final Widget title;
  final bool showNavButton;
  final String? stringTitle;
  const GradientBackgroundContainer(
      {super.key,
      required this.child,
      required this.title,
      this.stringTitle,
      required this.showNavButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        AppColors.primaryColor,
        AppColors.primaryColor.withOpacity(.5),
        AppColors.secondaryColor
      ])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        showNavButton == true
            ? Row(
                children: [
                  Container(
                    // margin: EdgeInsets.only(top: 12.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.h),

                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.whiteColor,
                        )),
                  ),
                  Text(
                    stringTitle ?? "",
                    style: const TextStyle(color: AppColors.whiteColor),
                  )
                ],
              )
            : SizedBox(
                height: 22.h,
              ),
        title,
        child
      ]),
    );
  }
}
