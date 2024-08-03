import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/data/models/employee.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/screens/employee/widgets/demography/bloc/employee_demography_bloc.dart';
import 'package:mobile_app/screens/home/employee/cubit/employee_cubit.dart';
import 'package:mobile_app/utils/dialogue/error_dialogue.dart';
import 'package:mobile_app/utils/dialogue/rating_dialogue.dart';
import 'package:mobile_app/utils/dialogue/success_dialogue.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';

@RoutePage()
class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;
  final auth = FirebaseAuth.instance;

  EmployeeDetailScreen({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => EmployeeCubit(context.read<EmployeeRepository>()),
        child: SafeArea(
          child: GradientBackgroundContainer(
            showNavButton: true,
            title: Container(
              padding: EdgeInsets.all(40.h),
            ),
            child: Expanded(
              child: Container(
                decoration:
                    AppConfig.getInsideScreenDecoration(AppColors.whiteColor),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(employee.profilePicturePath),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      employee.fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${employee.city}, ${employee.subCity}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.work,
                          color: Color(0xFF222262),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          employee.jobStatus == JobStatusEnum.fullTime
                              ? 'Full Time'
                              : 'Part Time',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF222262),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Color(0xFF222262),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          employee.phone,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF222262),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: BlocBuilder<EmployeeCubit, EmployeeState>(
                              builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))
                                  .copyWith(backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return AppColors.primaryColor.withOpacity(.7);
                                } else {
                                  return AppColors.primaryColor;
                                }
                              })).copyWith(),
                              onPressed: state.requestStatus ==
                                      FormzStatus.submissionInProgress
                                  ? null
                                  : () => context
                                      .read<EmployeeCubit>()
                                      .requestForEmployee(
                                          fullName: employee.fullName,
                                          employeeId: employee.id,
                                          employerId: auth.currentUser!.uid),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: state.requestStatus ==
                                        FormzStatus.submissionInProgress
                                    ? Center(
                                        child: SizedBox(
                                          height: 18.w,
                                          width: 18.w,
                                          child:
                                              const CircularProgressIndicator(
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        "Send Request",
                                        style: TextStyle(
                                            color: AppColors.whiteColor),
                                      ),
                              ),
                            );
                            // return CustomButton(
                            //   onTap: state.requestStatus ==
                            //           FormzStatus.submissionInProgress
                            //       ? null
                            //       : () => context
                            //           .read<EmployeeCubit>()
                            //           .requestForEmployee(
                            //               employeeId: employee.id,
                            //               employerId: auth.currentUser!.uid),
                            //   lable: "Request",
                            //   backgroundColor: AppColors.primaryColor,
                            // );
                          }),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        BlocConsumer<EmployeeCubit, EmployeeState>(
                            listener: (context, state) {
                          if (state.requestStatus ==
                              FormzStatus.submissionSuccess) {
                            showSuccessDialog(context,
                                "Request has been made for ${employee.fullName}. You will be updated after admin reviews your request, Thank You");
                          }

                          if (state.status == FormzStatus.submissionFailure ||
                              state.requestStatus ==
                                  FormzStatus.submissionFailure) {
                            showErrorDialog(
                                context,
                                state.errorMessage ??
                                    "Unknown error has occured while adding rating");
                          }
                          if (state.status == FormzStatus.submissionSuccess) {
                            showSuccessDialog(
                                context, "Rating successfully added");
                          }
                        }, builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                    splashFactory: NoSplash.splashFactory,
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)))
                                .copyWith(backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return AppColors.primaryColor.withOpacity(.7);
                              } else {
                                return AppColors.primaryColor;
                              }
                            })).copyWith(),
                            onPressed: () async {
                              try {
                                context
                                    .read<EmployeeCubit>()
                                    .setRating(employee.totalRating.toDouble());
                                final rating = await showDialog(
                                  context: context,
                                  builder: (context) => RatingDialog(
                                    initialRating:
                                        employee.totalRating.toDouble(),
                                  ),
                                );
                                context.read<EmployeeCubit>().updateRating(
                                    rating: rating,
                                    employeeId: employee.id,
                                    employerId: auth.currentUser!.uid);
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: state.status ==
                                      FormzStatus.submissionInProgress
                                  ? Center(
                                      child: SizedBox(
                                        height: 18.w,
                                        width: 18.w,
                                        child: const CircularProgressIndicator(
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      "Rate",
                                      style: TextStyle(
                                          color: AppColors.whiteColor),
                                    ),
                            ),
                          );
                          // return CustomButton(
                          //   onTap: () async {
                          //     try {
                          //       final auth = FirebaseAuth.instance;
                          //       final rating = await showDialog(
                          //         context: context,
                          //         builder: (context) => RatingDialog(
                          //           initialRating: employee.totalRating,
                          //         ),
                          //       );
                          //       context.read<EmployeeCubit>().updateRating(
                          //           employeeId: employee.id,
                          //           employerId: auth.currentUser!.uid);
                          //     } catch (e) {
                          //       print(e);
                          //     }
                          //   },
                          //   lable: "Rate",
                          //   backgroundColor: AppColors.primaryColor,
                          // );
                        }),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Handle request employee action
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: const Color(0xFF222262),
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 32, vertical: 12),
                        //     textStyle: const TextStyle(fontSize: 18),
                        //   ),
                        //   child: const Text('Request'),
                        // ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Handle open rating dialog action
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: const Color(0xFF222262),
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 32, vertical: 12),
                        //     textStyle: const TextStyle(fontSize: 18),
                        //   ),
                        //   child: const Text('Rate'),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
