import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/screens/home/employee/widgets/employee_request_list_view.dart';
import 'package:mobile_app/utils/widgets/employee_loading_shimmer.dart';

import '../../../../config/constants/app_colors.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.h),
              width: double.infinity,
              height: 150.h,
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Column(
                children: [
                  Row(
                    children: [
                      FutureBuilder(
                          future: context
                              .read<EmployeeRepository>()
                              .getEmployeeByCurrentUserUid(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ProfileShimmer();
                            }
                            if (snapshot.hasData) {
                              return Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () => context.router.push(
                                          EmployeeProfileRoute(
                                              employee: snapshot.data!)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4.h),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                              child: SizedBox(
                                                width: 35.w,
                                                height: 35.w,
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot
                                                      .data!.profilePicturePath,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    color: AppColors
                                                        .secondaryColor,
                                                    child: const Icon(
                                                      Icons.person,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ),
                                                // child: Image.network(
                                                //   snapshot.data!.profilePicturePath,
                                                //   fit: BoxFit.cover,
                                                // ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Column(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: snapshot.data!.fullName
                                                .split(' ')
                                                .map((String value) => Text(
                                                      value,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.sp),
                                                    ))
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.router.push(
                                            const EmployeeFeedbackRoute());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.whiteColor),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.white
                                          //         .withOpacity(0.2),
                                          //     spreadRadius: 2,
                                          //     blurRadius: 2,
                                          //     offset: const Offset(0, 2),
                                          //   ),
                                          // ]
                                        ),
                                        padding: EdgeInsets.all(4.w),
                                        child: Column(
                                          children: [
                                            Text(
                                              "feedback".tr(),
                                              style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            RatingBar.builder(
                                              itemSize: 10,
                                              initialRating: snapshot
                                                  .data!.totalRating
                                                  .toDouble(),
                                              minRating: 0,
                                              unratedColor:
                                                  Colors.white.withOpacity(.5),
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              ignoreGestures: true,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 12,
                                              ),
                                              onRatingUpdate: (rating) {
                                                // setState(() {
                                                //   this.rating = rating;
                                                // });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Icon(Icons.error);
                            }
                            return Container();
                          }),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: context
                        .read<EmployeeRepository>()
                        .getEmployeeRequests(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const EmployeeLoadingSkeleton();
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: EdgeInsets.all(28.w),
                          child: Center(
                              child: Text(
                            "request_fetch_error".tr(),
                            style: TextStyle(color: Colors.red.shade800),
                          )),
                        );
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "welcome_onboard".tr(),
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "no_job_requests".tr(),
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.list,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                    "job_requests".tr(),
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                              Expanded(
                                  child: EmployeeRequestList(
                                      requests: snapshot.data!)),
                            ],
                          ),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
