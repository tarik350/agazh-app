import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/home/bloc/home_bloc.dart';
import 'package:mobile_app/screens/home/widgets/employee_request_list_view.dart';
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
                      "Requested Employees",
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
                      "You can follow up your employee requests in here. Here are all the requests you have made so far",
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
              child: BlocConsumer<HomeBloc, HomeState>(
                listener: (BuildContext context, HomeState state) {},
                builder: (context, state) {
                  //todo
                  //get request in progress -> show shimmer
                  //
                  if (state.requestGetStatus ==
                      FormzStatus.submissionInProgress) {
                    return const EmployeeLoadingSkeleton();
                  }
                  if (state.requestGetStatus ==
                      FormzStatus.submissionFailure) {}
                  if (state.requestGetStatus == FormzStatus.submissionSuccess) {
                    if (state.requests == null || state.requests!.isEmpty) {
                      return Center(
                          child: Text(
                        "No request yet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 14.sp),
                      ));
                    }

                    return EmployeeRequestList(
                      requests: state.requests!,
                    );
                  }
                  return Container();
                  // if (snapshot.hasData) {
                  //   if (snapshot.data!.isNotEmpty) {
                  //   } else {}
                  // }
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  // }
                  // if (snapshot.hasError) {
                  //   //todo => show error view
                  //   print('error');
                  // }

                  // );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
