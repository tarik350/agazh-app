import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/utils/widgets/employee_loading_shimmer.dart';

import '../../config/constants/app_colors.dart';

class EmployeeHome extends StatelessWidget {
  const EmployeeHome({super.key});

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
                              return GestureDetector(
                                onTap: () => context.router.push(
                                    EmployeeProfileRoute(
                                        employee: snapshot.data!)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.h),
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
                                              color: AppColors.secondaryColor,
                                              child: const Icon(
                                                Icons.person,
                                                color: AppColors.primaryColor,
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
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp),
                                              ))
                                          .toList(),
                                    ),
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
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome Onboard",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "No job requests yet",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w200),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
