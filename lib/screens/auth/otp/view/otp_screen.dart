import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/screens/auth/otp/cubit/otp_cubit.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';

@RoutePage()
class OtpScreen extends StatelessWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserAuthDetailRepository>().getUserAuthDetail();
    final String title =
        user.role == SelectedRole.employee ? "Employee" : "Employer";
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => OtpCubit(6),
          child: GradientBackgroundContainer(
            showNavButton: true,
            title: Container(
              padding: AppConfig.insideContainerTitlePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verify Your Phone Number',
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
                      text:
                          'We have sent an OTP SMS message to the phone number ',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 13.sp,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '(${user.phoneNumber})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.h),
                        ),
                        const TextSpan(
                          text:
                              ' you provided please verify by providing the code.',
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
                    SizedBox(
                      height: 22.h,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BlocConsumer<OtpCubit, OtpState>(
                            listenWhen: (previous, current) =>
                                previous.status != current.status,
                            listener: (context, state) {
                              final role = context
                                  .read<UserAuthDetailRepository>()
                                  .getUserRole();
                              if (state.status == OtpStatus.submissionSuccess) {
                                if (role == SelectedRole.employer) {
                                  context.router
                                      .push(const EmployerStepperRoute());
                                } else if (role == SelectedRole.employee) {
                                  //todo route to emplyee stepper
                                  print('emplyee stepper not ready yet');
                                } else {
                                  //todo role is unknown
                                  //todo this shold never happen but if so we show a message indicating that role has not been selected
                                }
                                // context.router.push()
                              }
                              // context.router.push( RoleRoute());
                            },
                            builder: (context, state) {
                              return OtpTextField(
                                  margin: EdgeInsets.zero,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  numberOfFields: 6,
                                  focusedBorderColor: AppColors.primaryColor,
                                  contentPadding: EdgeInsets.all(12.w),
                                  fieldWidth: 42.w,
                                  borderWidth: 5.h,
                                  enabledBorderColor:
                                      AppColors.blackColor.withOpacity(.2),
                                  textStyle: TextStyle(
                                      fontSize: 18.sp,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                  showFieldAsBox: true,
                                  onCodeChanged: (code) => context
                                      .read<OtpCubit>()
                                      .onOtpStringChange(code),
                                  onSubmit: (code) => context
                                      .read<OtpCubit>()
                                      .setOptString(code));
                            },
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    BlocBuilder<OtpCubit, OtpState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status,
                      builder: (context, state) {
                        return CustomButton(
                          onTap: state.status == OtpStatus.valid
                              ? () {
                                  context.read<OtpCubit>().submitOptRequest(
                                        verificationId,
                                      );
                                }
                              : null,
                          lable: state.status == OtpStatus.submissionInProgress
                              ? "Loading..."
                              : "Submit",
                          backgroundColor: AppColors.primaryColor,
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
