import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/screens/auth/register/view/register_form.dart';
import 'package:mobile_app/screens/role/cubit/role_cubit.dart';
import 'package:mobile_app/screens/role/enums/role_status.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';

@RoutePage()
class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => RoleCubit(
              userAuthDetailRepository:
                  context.read<UserAuthDetailRepository>()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<RoleCubit, RoleState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        CustomButton(
                          onTap: () => context
                              .read<RoleCubit>()
                              .updateSelectedRole(SelectedRole.employee),
                          lable: "Employee",
                          backgroundColor: state.role == SelectedRole.employee
                              ? AppColors.primaryColor
                              : Colors.transparent,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomButton(
                          onTap: () => context
                              .read<RoleCubit>()
                              .updateSelectedRole(SelectedRole.employer),
                          lable: "Employer",
                          backgroundColor: state.role == SelectedRole.employer
                              ? AppColors.primaryColor
                              : Colors.transparent,
                        )
                      ],
                    );
                  },
                ),
                const Spacer(),
                BlocConsumer<RoleCubit, RoleState>(
                  listener: (context, state) {
                    if (state.status == RoleSubmissionStatus.submit) {
                      context.router.push(const RegisterRoute());
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        onTap: state.status == RoleSubmissionStatus.valid
                            ? () => context.read<RoleCubit>().setUserRole()
                            : null,
                        lable: "Submit",
                        backgroundColor: AppColors.primaryColor);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
