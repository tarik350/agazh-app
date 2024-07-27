import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/screens/auth/register/bloc/register_bloc.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/custom_textfiled.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          //todo => show error message
          final message = state.errorMessage;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(message ?? "Unknown error occured")),
            );
        }
      },
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(100.r),
                      child: Image.asset(
                        "assets/images/placeholder.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Center(
                child: Text(
                  "Welcolme to \nCompany Name.",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'all in one platform for to find and get a job',
                  style: TextStyle(
                      color: AppColors.primaryColor.withOpacity(.8),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              const _FullNameInput(),
              SizedBox(
                height: 12.h,
              ),
              _PhoneNumberInput(),
              SizedBox(
                height: 12.h,
              ),
              const _PasswordInput(),
              SizedBox(
                height: 40.h,
              ),
              const _SubmitButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _FullNameInput extends StatelessWidget {
  const _FullNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (previous, current) =>
              previous.fullName != current.fullName,
          builder: (context, state) {
            return CustomTextfield(
              hintText: 'Full Name',
              obscureText: false,
              onChanged: (fullName) =>
                  context.read<RegisterBloc>().add(FullNameChanged(fullName)),
              keyString: 'registerForm_fullNameInput_textfield',
              inputType: TextInputType.text,
              errorText:
                  state.fullName.invalid ? state.fullName.error?.message : null,
            );
          },
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return CustomTextfield(
            obscureText: false,
            inputType: TextInputType.phone,
            onChanged: (phone) =>
                context.read<RegisterBloc>().add(PhoneNumberChanged(phone)),
            hintText: 'Phone',
            keyString: 'registerForm_phoneNumberInput_textField',
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "Password",
            obscureText: false,
            onChanged: (password) =>
                context.read<RegisterBloc>().add(PasswordChanged(password)),
            keyString: "registerForm_passwordInput_textField",
            inputType: TextInputType.text,
            errorText:
                state.password.invalid ? state.password.error?.message : null);
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) => {
        if (state.status.isSubmissionSuccess)
          {context.router.push(OtpRoute(verificationId: state.verificationId!))}
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CustomButton(
          onTap: state.status.isValidated
              ? () => context.read<RegisterBloc>().add(RegisterFormSubmitted())
              : null,
          lable: "Regsiter",
          backgroundColor: Colors.black,
        );
      },
    );
  }
}
