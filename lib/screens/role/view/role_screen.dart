import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/screens/role/cubit/role_cubit.dart';
import 'package:mobile_app/screens/role/enums/role_status.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';

@RoutePage()
class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GradientBackgroundContainer(
          showNavButton: true,
          title: Container(
            padding: AppConfig.insideContainerTitlePadding,
            // padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      "role_title".tr(),
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
                      "role_subtitle".tr(),
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    )),
              ],
            ),
          ),
          child: Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: AppConfig.insideContainerPadding,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.r),
                            topLeft: Radius.circular(30.r))),
                    child: Column(
                      children: [
                        BlocBuilder<RoleCubit, RoleState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                _RoleButton(
                                  title: "employee".tr(),
                                  isSelected:
                                      state.userRole == UserRole.employee,
                                  onTab: () => context
                                      .read<RoleCubit>()
                                      .updateSelectedRole(UserRole.employee),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                _RoleButton(
                                  isSelected:
                                      state.userRole == UserRole.employer,
                                  title: "employer".tr(),
                                  onTab: () => context
                                      .read<RoleCubit>()
                                      .updateSelectedRole(UserRole.employer),
                                )
                                // CustomButton(
                                // onTap: () => context
                                //     .read<RoleCubit>()
                                //     .updateSelectedRole(
                                //         UserRole.employer),
                                //   lable: "Employer",
                                //   backgroundColor:
                                // state.role == UserRole.employer
                                //           ? AppColors.primaryColor
                                //           : Colors.transparent,
                                // )
                              ],
                            );
                          },
                        ),
                        const Spacer(),
                        BlocConsumer<RoleCubit, RoleState>(
                          listener: (context, state) async {
                            if (state.status == RoleSubmissionStatus.submit) {
                              context.router.push(const RegisterRoute());
                            }
                          },
                          builder: (context, state) {
                            return CustomButton(
                                onTap: state.status ==
                                        RoleSubmissionStatus.valid
                                    ? () =>
                                        context.read<RoleCubit>().setUserRole()
                                    : null,
                                lable: "submit".tr(),
                                backgroundColor: AppColors.primaryColor);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String title;
  final Function() onTab;
  final bool isSelected;
  const _RoleButton(
      {super.key,
      required this.title,
      required this.onTab,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleCubit, RoleState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTab,
          child: AnimatedContainer(
            padding: EdgeInsets.all(
              12.w,
            ),
            decoration: BoxDecoration(
                color: isSelected ? AppColors.succesColor : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(
                    width: 2.w,
                    color: isSelected
                        ? AppColors.succesColor
                        : AppColors.primaryColor)),
            duration: const Duration(milliseconds: 300),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: isSelected
                            ? AppColors.whiteColor
                            : AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp),
                  ),
                  Icon(
                    isSelected ? Icons.check_circle : Icons.error_rounded,
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                  )
                ]),
          ),
        );
      },
    );
  }
}
