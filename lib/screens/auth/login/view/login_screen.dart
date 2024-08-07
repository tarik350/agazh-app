import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/screens/auth/login/bloc/login_bloc.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/custom_textfiled.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';

import '../../../../utils/dialogue/language_selection_dialogue.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> items = [UserRole.employer.name, UserRole.employee.name];

  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GradientBackgroundContainer(
        showNavButton: false,
        title: Stack(
          children: [
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                  onPressed: () async {
                    String? selectedLanguage = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return const LanguageSelectionDialog();
                      },
                    );

                    if (selectedLanguage != null) {
                      // print('Selected Language: $selectedLanguage');

                      if (context.mounted) {
                        if (selectedLanguage.toLowerCase() == "amharic") {
                          context.setLocale(const Locale('am', 'ET'));
                        } else {
                          context.setLocale(const Locale('en', 'US'));
                        }
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.language,
                    color: AppColors.whiteColor,
                    size: 28,
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Text(
                          "login".tr(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 40),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: Text(
                          "welcome".tr(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.r))),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 12.h,
                ),
                FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: const Column(
                      children: [_PhoneNumberInput(), _PasswordInput()],
                    )),
                SizedBox(
                  height: 20.h,
                ),
                const _LoginButton(),
                SizedBox(
                  height: 20.h,
                ),
                const _RegisterButton()
                // FadeInUp(
                //     duration: const Duration(milliseconds: 1500),
                //     child: Align(
                //       alignment: Alignment.center,
                //       child: GestureDetector(
                //         onTap: () => {context.router.push(const RoleRoute())},
                //         child: Text(
                //           "create_account".tr(),
                //           textAlign: TextAlign.center,
                //           style: const TextStyle(
                //               color: AppColors.primaryColor,
                //               fontWeight: FontWeight.w600),
                //         ),
                //       ),
                //     ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// child: Column(
//         crossAxisAlignment = CrossAxisAlignment.start,
//         children = [
//           const SizedBox(
//             height: 80,
//           ),
//          ,
//           const SizedBox(height: 20),
//          ],
//       ),

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomTextfield(
            hintText: "phone_number".tr(),
            obscureText: false,
            onChanged: (value) =>
                context.read<LoginBloc>().add(PhoneNumberChanged(value)),
            keyString: "login_PhoneNumberInput_textfield",
            inputType: TextInputType.number,
            errorText: state.phoneNumber.invalid
                ? state.phoneNumber.error!.message
                : null);
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomTextfield(
            hintText: "pin".tr(),
            obscureText: false,
            onChanged: (value) =>
                context.read<LoginBloc>().add(PasswordChanged(value)),
            keyString: "login_PasswordInput_textfield",
            inputType: TextInputType.number,
            errorText:
                state.password.invalid ? state.password.error!.message : null);
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        duration: const Duration(milliseconds: 1600),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              context.router.push(OtpRoute(
                  verificationId: state.verificationId!,
                  route: "login",
                  userRole: state.userRole,
                  phoneNumber: state.phoneNumber.value));
            }
            if (state.status.isSubmissionFailure) {
              AppConfig.getMassenger(context, state.errorMessage);
            }
          },
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.userRole != current.userRole,
          builder: (context, state) {
            return CustomButton(
              onTap:
                  //validated and is not in progress validated && is not in progress
                  state.status.isValidated &&
                          !state.status.isSubmissionInProgress
                      ? () =>
                          context.read<LoginBloc>().add(LoginFormSubmitted())
                      : null,
              backgroundColor: AppColors.primaryColor,
              lable: state.status.isSubmissionInProgress
                  ? "loading".tr()
                  : "login".tr(),
            );
          },
        ));
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        duration: const Duration(milliseconds: 1500),
        child: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => {context.router.push(const RoleRoute())},
            child: Text(
              "create_account".tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}
