import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/home/widgets/employee_list_view.dart';
import 'package:mobile_app/utils/widgets/employee_loading_shimmer.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchString = '';
  @override
  Widget build(BuildContext context) {
    // final user = context.read<EmployerRepository>().getUser();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.h),
              width: double.infinity,
              // height: 150.h,
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Column(
                children: [
                  Row(
                    children: [
                      FutureBuilder(
                          future: context
                              .read<EmployerRepository>()
                              .getEmployerData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ProfileShimmer();
                            }
                            if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () => context.router.push(
                                    ProfileRoute(employer: snapshot.data!)),
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
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 30.h, bottom: 20.h),
                    child: TextFormField(
                      onChanged: (value) {
                        // setState(() {
                        //   searchString = value;
                        // });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        prefixIconConstraints:
                            BoxConstraints(maxWidth: 50.h, minWidth: 40.h),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.cancel_outlined),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 20.w), // Adjust vertical padding
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        errorStyle:
                            const TextStyle(fontWeight: FontWeight.w300),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        fillColor: AppColors.whiteColor,
                        filled: true,
                        hintText: "Type Employee Name",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: searchString.isNotEmpty
                      ? context
                          .read<EmployeeRepository>()
                          .searchEmployees(searchString)
                      : context
                          .read<EmployeeRepository>()
                          .fetchEmployeesOrderedByRating(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const EmployeeLoadingSkeleton();
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            "No Registered \n Employee's yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                                fontSize: 14.sp),
                          ),
                        );
                      }
                      return EmployeeProfileList(users: snapshot.data!);
                    }
                    if (snapshot.hasError) {
                      return Padding(
                        padding: EdgeInsets.all(28.w),
                        child: Center(
                            child: Text(
                          "Error while fetching employee's",
                          style: TextStyle(color: Colors.red.shade800),
                        )),
                      );
                    }
                    return Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
