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
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../services/auth_service.dart';
import '../../../../services/init_service.dart';
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                AppColors.primaryColor,
                AppColors.primaryColor.withOpacity(.5),
                AppColors.secondaryColor
              ],
            ),
          ),
          child: Column(
            // mainAxisSize:
            //     MainAxisSize.min, // Ensure the Column takes minimum space
            children: [
              SizedBox(height: 50.h),
              SizedBox(
                height: 50.h,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0.h,
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
                                if (selectedLanguage.toLowerCase() ==
                                    "amharic") {
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
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: SizedBox(
                  height: 140.h,
                  child: Image.asset('assets/images/agazh.png'),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 1300),
                child: Text(
                  "welcome".tr(),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: Column(
                  children: [
                    const _PhoneNumberInput(),
                    SizedBox(height: 12.h),
                    const _PasswordInput(),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              _LoginButton(),
              SizedBox(height: 20.h),
              // const Spacer(),
              const _RegisterButton(),
              // SizedBox(
              //   height: 22.h,
              // )
            ],
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
        return LoginTextField(
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
        return LoginTextField(
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
  _LoginButton({super.key});
  final _authService = getit<AuthService>();

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        duration: const Duration(milliseconds: 1600),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state.status.isSubmissionSuccess) {
              final userRole = state.userRole;
              final preference = await SharedPreferences.getInstance();
              // if ( userRole ) {
              preference.setString('role', userRole.name);
              if (context.mounted) {
                await _authService.setIsAuthenticated();
                if (context.mounted) {
                  context.router.replaceAll([const AgazhAppRoute()]);
                }
              }
              //REDIRECT TO OTP PAGE ON LOGIN
              // context.router.push(OtpRoute(
              //     verificationId: state.verificationId!,
              //     route: "login",
              //     userRole: state.userRole,
              //     phoneNumber: state.phoneNumber.value));
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

class LoginTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(dynamic) onChanged;
  final String keyString;
  final String? errorText;
  final TextInputType inputType;
  final String? initialValue;
  final Widget? suffix;
  final int? maxLines;

  const LoginTextField(
      {super.key,
      // required this.controller,
      this.initialValue,
      this.maxLines,
      required this.hintText,
      required this.obscureText,
      required this.onChanged,
      required this.keyString,
      required this.inputType,
      required this.errorText,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      initialValue: initialValue,
      obscureText: obscureText,
      key: Key(keyString),
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10.h)),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(fontWeight: FontWeight.w300),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          fillColor: AppColors.primaryColor.withOpacity(.1),
          filled: true,
          labelText: hintText,
          labelStyle:
              TextStyle(fontSize: 12.sp, color: Colors.black.withOpacity(.5)),
          errorMaxLines: 3,
          errorText: errorText?.tr(),
          hintStyle: TextStyle(color: Colors.grey.shade500)),
    );
  }
}
