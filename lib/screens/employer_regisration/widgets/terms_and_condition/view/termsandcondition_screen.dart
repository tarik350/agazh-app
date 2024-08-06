import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/terms_and_condition/cubit/terms_and_conditions_cubit.dart';
import 'package:mobile_app/screens/role/cubit/role_cubit.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';

import 'package:mobile_app/utils/widgets/custom_textfiled.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TermsandconditionCubit.TermsAndConditionCubit(
          employeeRepository: context.read<EmployeeRepository>(),
          employerRepositroy: context.read<EmployerRepository>()),
      child: BlocConsumer<TermsandconditionCubit, TermsAndConditionState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content:
                        Text(state.errorMessage ?? 'Something went wrong!')),
              );
          } else if (state.status.isSubmissionSuccess) {
            context.router.push(SiraAppRoute());
          }
        },
        builder: (context, state) {
          final user = context.read<EmployerRepository>().getUser();
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _PasswordInput(),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Theme(
                        data: ThemeData(
                          splashColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                        child: Checkbox(
                          activeColor: AppColors.primaryColor,
                          value: state.isChecked,
                          onChanged: (value) => context
                              .read<TermsandconditionCubit>()
                              .onCheckBoxChange(value!),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const Expanded(
                      child: Text(
                          "By Checking this checkbox you agree with our Terms and conditions."),
                    )
                  ],
                ),
                const Spacer(),
                CustomButton(
                  onTap: state.isChecked &&
                          state.status.isValidated &&
                          !state.status.isSubmissionInProgress
                      ? () => context
                          .read<TermsandconditionCubit>()
                          .saveUser(context.read<RoleCubit>().state.userRole)
                      : null,
                  lable: state.status.isSubmissionInProgress
                      ? "Loading..."
                      : "Save",
                  backgroundColor: AppColors.primaryColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermsandconditionCubit, TermsAndConditionState>(
      builder: (context, state) {
        return CustomTextfield(
            hintText: "PIN",
            obscureText: false,
            onChanged: (value) =>
                context.read<TermsandconditionCubit>().onPinChanged(value),
            keyString: "login_PasswordInput_textfield",
            inputType: TextInputType.number,
            errorText: state.pin.invalid ? state.pin.error!.message : null);
      },
    );
  }
}
