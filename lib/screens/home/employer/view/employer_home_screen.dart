import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/home/bloc/home_bloc.dart';
import 'package:mobile_app/screens/home/employer/widgets/employee_list_view.dart';
import 'package:mobile_app/utils/widgets/employee_loading_shimmer.dart';

@RoutePage()
class EmployerHomeScreen extends StatefulWidget {
  const EmployerHomeScreen({super.key});

  @override
  State<EmployerHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<EmployerHomeScreen> {
  String searchString = '';
  String filterString = '';
  List<Map<String, dynamic>> filters = [
    {"title": "Kitchen Staff", "icon": Icons.kitchen},
    {"title": "Cleaner", "icon": Icons.cleaning_services},
    {"title": "Full Time Housekeeper", "icon": Icons.person},
    {"title": "Part Time Housekeeper", "icon": Icons.person},
    {"title": "Nanny", "icon": Icons.person}
  ];

  @override
  void initState() {
    context.read<HomeBloc>().add(const GetEmployee());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.read<EmployerRepository>().getUser();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EmployerHomeTitle(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                      Expanded(
                        child: Text(
                          "home_title".tr(),
                          // filterString.isNotEmpty
                          //     ? "All $filterString's"
                          //     : "All Employees ",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp),
                        ),
                      ),
                    ],
                  ),
                  Theme(
                    data: ThemeData().copyWith(
                        listTileTheme: ListTileThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          minVerticalPadding: 0.0,
                          visualDensity: const VisualDensity(vertical: -4),
                          horizontalTitleGap: 0.0,
                          minLeadingWidth: 0,
                          dense: true,
                        ),
                        dividerColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory),
                    child: ExpansionTile(
                        // expandedAlignment: Alignment.centerRight,
                        // expandedCrossAxisAlignment: CrossAxisAlignment.end,
                        // childrenPadding: EdgeInsets.zero,
                        tilePadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            Icon(
                              Icons.filter_alt,
                              color: AppColors.primaryColor,
                              size: 16.sp,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              "filter".tr(),
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            //clear filter only if there is filter
                            if (filterString.isNotEmpty) {
                              context.read<HomeBloc>().add(const GetEmployee());
                            }
                            setState(() {
                              filterString = '';
                            });
                          },
                          child: Text(
                            'clear_filter'.tr(),
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                          ),
                        ),
                        children: [
                          SizedBox(
                            // padding: EdgeInsets.symmetric(vertical: 18.h),
                            height: 40.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: filters.length,
                                itemBuilder: (context, index) {
                                  final filter = filters[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filterString = filter['title'];
                                      });
                                      context.read<HomeBloc>().add(
                                          GetEmployee(filter: filter['title']));
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: filterString == filter['title']
                                              ? AppColors.primaryColor
                                              : AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 1)),
                                      child: Row(
                                        children: [
                                          Icon(filter['icon'],
                                              size: 19.h,
                                              color: filterString ==
                                                      filter['title']
                                                  ? AppColors.whiteColor
                                                  : AppColors.primaryColor),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text(
                                            "other_detail.${AppConfig.toSnakeCase(filter['title'])}"
                                                .tr(),
                                            style: TextStyle(
                                                color: filterString ==
                                                        filter['title']
                                                    ? AppColors.whiteColor
                                                    : AppColors.primaryColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                  // future: context
                  // .read<EmployeeRepository>()
                  // .fetchEmployeesOrderedByRating(),
                  builder: (context, state) {
                if (state is GetEmployeeLoading) {
                  return const EmployeeLoadingSkeleton();
                }
                if (state is GetEmployeeEmpty) {
                  return Center(
                    child: Text(
                      "no_registered_employees".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 14.sp),
                    ),
                  );
                }
                if (state is GetEmployeeEmptyForFilter) {
                  return Center(
                      child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${tr('no')} ',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: const Color.fromARGB(255, 40, 40, 59),
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text:
                              "other_detail.${AppConfig.toSnakeCase(state.filter)}"
                                  .tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: '\n',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: tr("employees_for_now"),
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ));
                }
                if (state is GetEmployeeLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: EmployeeProfileList(users: state.employees),
                  );
                }
                if (state is GetEmployeeError) {
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

class EmployerHomeTitle extends StatelessWidget {
  EmployerHomeTitle({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      width: double.infinity,
      // height: 150.h,
      decoration: const BoxDecoration(color: AppColors.primaryColor),
      child: Column(
        children: [
          Row(
            children: [
              FutureBuilder(
                  future: context.read<EmployerRepository>().getEmployerData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ProfileShimmer();
                    }
                    if (snapshot.hasData) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: SizedBox(
                                width: 35.w,
                                height: 35.w,
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.profilePicturePath,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
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
                          Text(
                            "${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                          //todo old code below -> review changes
                          // Column(
                          //   // mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: snapshot.data!.fullName
                          //       .split(' ')
                          //       .map((String value) => Text(
                          //             value,
                          //             textAlign: TextAlign.start,
                          //             style: TextStyle(
                          //                 color: AppColors.whiteColor,
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 14.sp),
                          //           ))
                          //       .toList(),
                          // ),
                        ],
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
              controller: searchController,
              onChanged: (value) {
                context.read<HomeBloc>().add(GetEmployee(name: value));
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                prefixIconConstraints:
                    BoxConstraints(maxWidth: 50.h, minWidth: 40.h),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    context.read<HomeBloc>().add(const GetEmployee());
                  },
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
                errorStyle: const TextStyle(fontWeight: FontWeight.w300),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                fillColor: AppColors.whiteColor,
                filled: true,
                hintText: "type_employee_name".tr(),
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
    );
  }
}
