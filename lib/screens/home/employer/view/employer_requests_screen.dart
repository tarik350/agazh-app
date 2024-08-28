import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/home/bloc/home_bloc.dart';
import 'package:mobile_app/screens/home/employer/widgets/employer_request_list_view.dart';
import 'package:mobile_app/utils/widgets/employee_loading_shimmer.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';

@RoutePage()
class EmployerRequestScreen extends StatelessWidget {
  const EmployerRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GradientBackgroundContainer(
          showNavButton: true,
          title: Container(
            // padding: AppConfig.insideContainerTitlePadding,
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      "my_request_title".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.sp),
                    )),
                const SizedBox(
                  height: 10,
                ),
                FadeInUp(
                    duration: const Duration(milliseconds: 1300),
                    child: Text(
                      "my_request_subtitle".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    )),
              ],
            ),
          ),
          child: Expanded(
            child: Container(
              // padding: AppConfig.insideContainerPadding,
              padding: EdgeInsets.all(12.sp),
              decoration:
                  AppConfig.getInsideScreenDecoration(AppColors.whiteColor),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.requestGetStatus ==
                      FormzSubmissionStatus.inProgress) {
                    return const EmployeeLoadingSkeleton();
                  }
                  if (state.requestGetStatus ==
                      FormzSubmissionStatus.failure) {}
                  if (state.requestGetStatus == FormzSubmissionStatus.success) {
                    if (state.requests == null || state.requests!.isEmpty) {
                      return Center(
                          child: Text(
                        "no_request_yet".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 14.sp),
                      ));
                    }

                    return EmployerRequestList(
                      requests: state.requests!,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
