import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/data/models/employee.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employee/widgets/demography/bloc/employee_demography_bloc.dart';
import 'package:mobile_app/utils/dialogue/error_dialogue.dart';
import 'package:mobile_app/utils/dialogue/rating_dialogue.dart';
import 'package:mobile_app/utils/dialogue/success_dialogue.dart';
import 'package:mobile_app/utils/widgets/gradient_background_container.dart';

import '../cubit/employer_cubit.dart';

@RoutePage()
class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;
  final auth = FirebaseAuth.instance;

  EmployeeDetailScreen({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => EmployerCubit(
            employerRepository: context.read<EmployerRepository>()),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          employee.fullName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 15,
                          initialRating: employee.totalRating.toDouble(),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 12,
                          ),
                          onRatingUpdate: (rating) {
                            // setState(() {
                            //   this.rating = rating;
                            // });
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 25.h),
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
                          tr(employee.jobStatus == JobStatusEnum.fullTime
                              ? 'demography.full_time'
                              : 'demography.part_time'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222262),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${"other_detail.age".tr()} :",
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        // const Icon(
                        //   Icons.calendar_month,
                        //   color: Color(0xFF222262),
                        // ),
                        const SizedBox(width: 8),
                        Text(
                          employee.age.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222262),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${'profession'.tr()} :",
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        // const Icon(
                        //   Icons.calendar_month,
                        //   color: Color(0xFF222262),
                        // ),
                        const SizedBox(width: 8),
                        Text(
                          "other_detail.${AppConfig.toSnakeCase(employee.workType)}"
                              .tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222262),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${'other_detail.religion'.tr()} :",
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        // const Icon(
                        //   Icons.calendar_month,
                        //   color: Color(0xFF222262),
                        // ),
                        const SizedBox(width: 8),
                        Text(
                          employee.religion,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
                          child: BlocBuilder<EmployerCubit, EmployerState>(
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
                                      .read<EmployerCubit>()
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
                                    : Text(
                                        "send_request".tr(),
                                        style: const TextStyle(
                                            color: AppColors.whiteColor),
                                      ),
                              ),
                            );
                            // return CustomButton(
                            //   onTap: state.requestStatus ==
                            //           FormzStatus.submissionInProgress
                            //       ? null
                            //       : () => context
                            //           .read<EmployerCubit>()
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
                        BlocConsumer<EmployerCubit, EmployerState>(
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
                                    .read<EmployerCubit>()
                                    .setRating(employee.totalRating.toDouble());
                                final response = await showDialog(
                                  context: context,
                                  builder: (context) => RatingDialog(
                                    initialRating:
                                        employee.totalRating.toDouble(),
                                  ),
                                );
                                context.read<EmployerCubit>().updateRating(
                                    rating: response['rating'],
                                    employeeId: employee.id,
                                    employerId: auth.currentUser!.uid,
                                    feedback: response['feedback']);
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
                                  : Text(
                                      "rate".tr(),
                                      style: const TextStyle(
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
                          //       context.read<EmployerCubit>().updateRating(
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
