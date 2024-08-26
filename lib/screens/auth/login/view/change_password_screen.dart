import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/screens/auth/login/bloc/login_bloc.dart';
import 'package:mobile_app/screens/home/bloc/home_bloc.dart';
import 'package:mobile_app/utils/dialogue/error_dialogue.dart';
import 'package:mobile_app/utils/dialogue/success_dialogue.dart';
import 'package:mobile_app/utils/widgets/custom_textfiled.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';

import '../../../../utils/widgets/custom_button.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GradientBackgroundContainer(
        showNavButton: true,
        title: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    "change_pin_title".tr(),
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
                    "change_pin_subtitle".tr(),
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  )),
            ],
          ),
        ),
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.changePinStatus.isSubmissionFailure) {
              showErrorDialog(context, "pin_changed_error_message".tr());
            }
            if (state.changePinStatus.isSubmissionSuccess) {
              showSuccessDialog(context, "pin_changed_success_message".tr());
            }
          },
          child: Expanded(
            child: Container(
              // padding: AppConfig.insideContainerPadding,
              padding: EdgeInsets.all(12.sp),
              decoration:
                  AppConfig.getInsideScreenDecoration(AppColors.whiteColor),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _PasswordInput(),
                    SizedBox(
                      height: 12.h,
                    ),
                    const _ConfirmPasswordInput(),
                    const Spacer(),
                    const _SubmitButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomTextfield(
            hintText: "pin".tr(),
            obscureText: false,
            onChanged: (value) =>
                context.read<HomeBloc>().add(PINChanged(value)),
            keyString: "changepassword_PasswordInput_textfield",
            inputType: TextInputType.number,
            errorText: state.pin.invalid ? state.pin.error!.message : null);
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomTextfield(
            hintText: "confirm_pin".tr(),
            obscureText: false,
            onChanged: (value) =>
                context.read<HomeBloc>().add(ConfirmPinChanged(value)),
            keyString: "changepassword_confirmPassword_textfield",
            inputType: TextInputType.number,
            errorText: state.confirmPin.invalid
                ? state.confirmPin.error!.message
                : null);
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.changePinStatus != current.changePinStatus,
      builder: (context, state) {
        return CustomButton(
          onTap: state.changePinStatus.isValidated &&
                  !state.changePinStatus.isSubmissionInProgress
              ? () => context.read<HomeBloc>().add(ChangePasswordEvent())
              : null,
          lable: state.changePinStatus.isSubmissionInProgress
              ? "loading".tr()
              : "change".tr(),
          backgroundColor: AppColors.primaryColor,
        );
      },
    );
  }
}
