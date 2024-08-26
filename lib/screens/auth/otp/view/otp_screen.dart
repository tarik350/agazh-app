import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';

import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/auth/otp/cubit/otp_cubit.dart';
import 'package:mobile_app/screens/role/cubit/role_cubit.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/init_service.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class OtpScreen extends StatelessWidget {
  final String verificationId;
  final String route;
  final String phoneNumber;
  final UserRole? userRole;

  OtpScreen(
      {super.key,
      required this.verificationId,
      required this.route,
      this.userRole,
      this.phoneNumber = ''});
  // String getTitle() {}

  final _authService = getit<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<OtpCubit>(
          create: (_) => OtpCubit(6),
          child: GradientBackgroundContainer(
            showNavButton: true,
            title: Container(
              padding: AppConfig.insideContainerTitlePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'otp_title'.tr(),
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'otp_subtitle'.tr(),
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 13.sp,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '(${phoneNumber.isNotEmpty ? phoneNumber : context.read<RoleCubit>().state.userRole == UserRole.employer ? context.read<EmployerRepository>().getUser()!.phone : context.read<EmployeeRepository>().getUser()!.phone})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.h),
                        ),
                        TextSpan(
                          text: 'otp_subtitle_trailing'.tr(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            child: Expanded(
              child: Container(
                padding: AppConfig.insideContainerPadding,
                decoration: AppConfig.getInsideScreenDecoration(null),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: BlocBuilder<OtpCubit, OtpState>(
                        builder: (context, state) {
                          return Text(
                            "resend_otp_in".tr(args: [state.countdown]),
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BlocConsumer<OtpCubit, OtpState>(
                            listenWhen: (previous, current) =>
                                previous.otpSubmissionStatus !=
                                    current.otpSubmissionStatus ||
                                previous.resendStatus != current.resendStatus,
                            listener: (context, state) async {
                              if (state.resendStatus == ResendStatus.success) {
                                AppConfig.getMassenger(
                                    context, "resend_success_message".tr());
                              }
                              if (state.resendStatus == ResendStatus.failed) {
                                AppConfig.getMassenger(
                                    context, "resend_failed_message".tr());
                              }
                              if (state.otpSubmissionStatus ==
                                  OtpStatus.submissionSuccess) {
                                final preferance =
                                    await SharedPreferences.getInstance();
                                if (route == 'login' && userRole != null) {
                                  preferance.setString('role', userRole!.name);
                                  if (context.mounted) {
                                    await _authService.setIsAuthenticated();
                                    if (context.mounted) {
                                      context.router
                                          .replaceAll([const SiraAppRoute()]);
                                    }
                                  }
                                } else if (route == 'register') {
                                  if (context.mounted) {
                                    final role = context
                                        .read<RoleCubit>()
                                        .state
                                        .userRole;
                                    preferance.setString('role', role.name);

                                    if (role == UserRole.employee) {
                                      //route to employee stepper
                                      context.router.replaceAll(
                                          [const EmployeeStepperRoute()]);
                                    } else if (role == UserRole.employer) {
                                      context.router.replaceAll(
                                          [const EmployerStepperRoute()]);
                                      //route to employer stepper
                                    }
                                  }
                                }
                              }

                              if (state.otpSubmissionStatus ==
                                  OtpStatus.submissionFailure) {
                                if (context.mounted) {
                                  AppConfig.getMassenger(context,
                                      "otp_verification_failed_message".tr());
                                }
                              }
                            },
                            builder: (context, state) {
                              return PinCodeTextField(
                                appContext: context,
                                backgroundColor: Colors.transparent,
                                pastedTextStyle: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 6,
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  // fieldHeight: 60.h,
                                  // fieldWidth: 60.h,
                                  //color when inputs are not selected
                                  inactiveFillColor: Colors.transparent,
                                  inactiveBorderWidth: 3.w,
                                  selectedBorderWidth: 4.w,
                                  //border color when inputs are not selected
                                  inactiveColor: AppColors.primaryColor,

                                  //fill color and border color for a box that has a value
                                  activeColor: AppColors.primaryColor,
                                  activeFillColor:
                                      AppColors.primaryColor.withOpacity(.3),
                                  //fill color for focused pin box's
                                  selectedFillColor:
                                      AppColors.primaryColor.withOpacity(.3),
                                  activeBorderWidth: 3.w,
                                  disabledColor: AppColors.primaryColor,
                                  selectedColor: AppColors.primaryColor,
                                ),

                                cursorColor: Colors.black,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: true,

                                keyboardType: TextInputType.number,
                                boxShadows: const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                                onCompleted: (v) =>
                                    context.read<OtpCubit>().setOptString(v),
                                // onTap: () {
                                //   debugPrint("Pressed");
                                // },
                                onChanged: (value) {
                                  debugPrint(value);
                                },
                                beforeTextPaste: (text) {
                                  debugPrint("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                                validator: (v) {
                                  if (v!.length != 6) {
                                    context
                                        .read<OtpCubit>()
                                        .changeOtpStringStatus();
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    BlocBuilder<OtpCubit, OtpState>(
                      // buildWhen: (previous, current) =>
                      // previous.otpStringStatus != current.otpStringStatus,
                      builder: (context, state) {
                        return Column(
                          children: [
                            CustomButton(
                              onTap: state.otpStringStatus == OtpStatus.valid &&
                                      state.otpSubmissionStatus !=
                                          OtpStatus.submissionInProgress
                                  ? () => context
                                      .read<OtpCubit>()
                                      .submitOptRequest(verificationId)
                                  : null,
                              lable: state.otpSubmissionStatus ==
                                      OtpStatus.submissionInProgress
                                  ? "loading".tr()
                                  : "submit".tr(),
                              backgroundColor: AppColors.primaryColor,
                            ),
                            Center(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      foregroundColor: AppColors.primaryColor,
                                      splashFactory: NoSplash.splashFactory,
                                      textStyle: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: state.isResendDisabled
                                      ? null
                                      : () {
                                          context
                                              .read<OtpCubit>()
                                              .resendOtp(phoneNumber);
                                        },
                                  child: Text('resend_otp'.tr())),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
