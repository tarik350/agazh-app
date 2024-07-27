import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/screens/auth/otp/cubit/otp_cubit.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';

@RoutePage()
class OtpScreen extends StatelessWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserAuthDetailRepository>().getUserAuthDetail();
    final String title =
        user.role == SelectedRole.employee ? "Employee" : "Employer";
    return BlocProvider<OtpCubit>(
      create: (context) => OtpCubit(6),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title Form",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 33.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 22.h,
              ),
              Text(
                'Hey There, ${user.fullName}',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 33.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12.h,
              ),
              RichText(
                text: TextSpan(
                  text: 'We have sent an OTP message to the phone number ',
                  style: TextStyle(
                    color: AppColors.primaryColor.withOpacity(.8),
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
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
              // Text(
              //   'We have sent on OTP message to the phone number (${user.phoneNumber}) you provided please verify by providing the code.',
              //   style: TextStyle(
              //       color: AppColors.primaryColor.withOpacity(.8),
              //       fontWeight: FontWeight.normal,
              //       fontSize: 12.sp),
              // ),
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
                            context.router.push(const EmployerStepperRoute());
                          } else {
                            //route te employee stepper
                            print('emplyee stepper not ready yet');
                          }
                          // context.router.push()
                        }
                        // context.router.push(const RoleRoute());
                      },
                      builder: (context, state) {
                        return OtpTextField(
                            numberOfFields: 6,
                            focusedBorderColor: AppColors.primaryColor,
                            enabledBorderColor:
                                AppColors.blackColor.withOpacity(.4),
                            contentPadding: EdgeInsets.all(12.w),
                            margin: EdgeInsets.all(8.w),
                            borderWidth: 5.h,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            showFieldAsBox: false,
                            onCodeChanged: (code) => context
                                .read<OtpCubit>()
                                .onOtpStringChange(code),
                            onSubmit: (code) =>
                                context.read<OtpCubit>().setOptString(code));
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
                        ? () => context.read<OtpCubit>().submitOptRequest(
                              verificationId,
                            )
                        : null,
                    lable: state.status == OtpStatus.submissionInProgress
                        ? "Loading..."
                        : "Submit",
                    backgroundColor: Colors.black,
                  );
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
