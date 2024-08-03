import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/screens/auth/register/bloc/register_bloc.dart';
import 'package:mobile_app/screens/auth/register/view/register_form.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
          child: GradientBackgroundContainer(
              showNavButton: true,
              title: Container(
                padding: AppConfig.insideContainerTitlePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Text(
                          "Please Enter Your Phone Number",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: Text(
                          "Phone Number should start with (+251)",
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        )),
                  ],
                ),
              ),
              child: Expanded(
                  child: Container(
                      padding: AppConfig.insideContainerPadding,
                      decoration: AppConfig.getInsideScreenDecoration(null),
                      child: const RegisterForm()))),
        ),
      ),
    );
  }
}
