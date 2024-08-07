import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/screens/employer_regisration/cubit/employer_registration_cubit.dart';
import 'package:mobile_app/screens/employer_regisration/view/employer_stepper.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';

@RoutePage()
class EmployerStepperScreen extends StatelessWidget {
  const EmployerStepperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider<EmployerRegistrationCubit>(
          create: (_) => EmployerRegistrationCubit(3),
          child: GradientBackgroundContainer(
              showNavButton: false,
              title: Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Text(
                          "employer_stepper_title".tr(),
                          textAlign: TextAlign.start,
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
                          "stepper_subtitle".tr(),
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        )),
                  ],
                ),
              ),
              child: Expanded(
                child: Container(
                    padding: EdgeInsets.only(
                        top: 12.h, left: 20.w, right: 20.w, bottom: 30.h),
                    decoration: AppConfig.getInsideScreenDecoration(null),
                    child: const EmployerStepper()),
              )),
        ),
      ),
    );
  }
}
