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

  const OtpScreen(
      {super.key,
      required this.verificationId,
      required this.route,
      this.userRole,
      this.phoneNumber = ''});
  // String getTitle() {}

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
                    // Center(
                    //   child: Text(
                    //       '${context.select((TimerBloc bloc) => bloc.state.duration)}'),
                    // ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BlocConsumer<OtpCubit, OtpState>(
                            listenWhen: (previous, current) =>
                                previous.otpSubmissionStatus !=
                                current.otpSubmissionStatus,
                            listener: (context, state) async {
                              //get the role
                              //if it is registration we could get it from role cubit
                              //other wise we have to look up the user in either of the collection
                              //get the doc get the role
                              //other wise we could add a drop down for selecting role on login
                              //and pass it to otp page when routing from login

                              //gets have two separate blocs for handling routing in otp screen

                              //on register if role is employee we go emplyee stepper
                              //or we go to employer stepper

                              //on login if role is employee we go to employee home page
                              //or we go to employer home page
                              if (state.otpSubmissionStatus ==
                                  OtpStatus.submissionSuccess) {
                                final preferance =
                                    await SharedPreferences.getInstance();
                                if (route == 'login' && userRole != null) {
                                  preferance.setString('role', userRole!.name);
                                  context.router.push(const SiraAppRoute());
                                  // if (userRole == UserRole.employee) {
                                  //   context.router.push(route)
                                  // } else {
                                  // }
                                  // take role from params
                                  //here if role is null we throw an exception
                                } else if (route == 'register') {
                                  final role =
                                      context.read<RoleCubit>().state.userRole;
                                  preferance.setString('role', role.name);

                                  if (role == UserRole.employee) {
                                    //route to employee stepper
                                    context.router
                                        .push(const EmployeeStepperRoute());
                                  } else if (role == UserRole.employer) {
                                    context.router
                                        .push(const EmployerStepperRoute());
                                    //route to employer stepper
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
                              // final role =
                              //     context.read<RoleCubit>().state.userRole !=
                              //             UserRole.none
                              //         ? context.read<RoleCubit>().state.userRole
                              //         : "get user role from auth service";
                              // if (state.otpSubmissionStatus ==
                              //     OtpStatus.submissionFailure) {
                              //   //todo => handle submission status
                              // }

                              // if (state.otpSubmissionStatus ==
                              //     OtpStatus.submissionSuccess) {
                              //   switch (role) {
                              //     case UserRole.employee:
                              //       if (route == 'login') {
                              //         //todo -> route to home
                              //       } else {
                              //         //todo -> route to stepper
                              //       }
                              //       break;
                              //     case UserRole.employer:
                              //       if (route == 'signup') {
                              //         context.router
                              //             .push(const EmployerStepperRoute());
                              //       } else {
                              //         context.router.push(SiraApp());
                              //       }
                              //       break;
                              //     default:
                              //   }

                              //   // if (role == UserRole.employer) {
                              //   // } else if (role == UserRole.employee) {
                              //   //   //todo route to emplyee stepper
                              //   // } else {}
                              // }
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
                                      splashFactory: NoSplash.splashFactory,
                                      textStyle: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: state.isResendDisabled
                                      ? null
                                      : () {
                                          context.read<OtpCubit>().resendOtp();
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
//instaruction for otp

//  RichText(
//                     text = TextSpan(
//                       children: [
//                         TextSpan(
//                           text:
//                               'Please enter the 6-digit OTP code that was sent to you via SMS.\n\n',
//                           style: TextStyle(
//                               color: Colors.black.withOpacity(.5),
//                               fontSize: 13.sp),
//                         ),
//                         TextSpan(
//                           text: 'Instructions\n',
//                           style: TextStyle(
//                               color: Colors.black.withOpacity(.8),
//                               fontSize: 13.sp,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         WidgetSpan(
//                             child: SizedBox(
//                           height: 28.h,
//                         )),
//                         TextSpan(
//                           text:
//                               '1. Tap on the first field below to start entering the code.\n',
//                           style: TextStyle(
//                               color: Colors.grey[700], fontSize: 13.sp),
//                         ),
//                         WidgetSpan(
//                             child: SizedBox(
//                           height: 22.h,
//                         )),
//                         TextSpan(
//                           text: '2. Enter the numbers one by one.\n',
//                           style: TextStyle(
//                               color: Colors.grey[700], fontSize: 13.sp),
//                         ),
//                         WidgetSpan(
//                             child: SizedBox(
//                           height: 22.h,
//                         )),
//                         TextSpan(
//                           text: '3. The OTP code contains only numbers.\n',
//                           style: TextStyle(
//                               color: Colors.grey[700], fontSize: 13.sp),
//                         ),
//                       ],
//                     ),
//                   ),

// margin: EdgeInsets.zero,
// mainAxisAlignment:
//     MainAxisAlignment.spaceBetween,
// numberOfFields: 6,
// focusedBorderColor: AppColors.primaryColor,
// contentPadding: EdgeInsets.all(12.w),
// fieldWidth: 42.w,
// borderWidth: 5.h,
// enabledBorderColor:
//     AppColors.blackColor.withOpacity(.2),
// textStyle: TextStyle(
//     fontSize: 18.sp,
//     color: AppColors.primaryColor,
//     fontWeight: FontWeight.bold),
// borderRadius:
//     BorderRadius.all(Radius.circular(8.r)),
// showFieldAsBox: true,
// onCodeChanged: (code) => context
//     .read<OtpCubit>()
//     .onOtpStringChange(code),
// onSubmit: (code) => context
//     .read<OtpCubit>()
//     .setOptString(code)
