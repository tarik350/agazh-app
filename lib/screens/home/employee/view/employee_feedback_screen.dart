import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/screens/home/employee/widgets/employee_feedback_list.dart';

import '../../../../utils/widgets/employee_loading_shimmer.dart';

@RoutePage()
class EmployeeFeedbackScreen extends StatelessWidget {
  const EmployeeFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text(
              "Feedback",
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            )),
        body: SafeArea(
            child: FutureBuilder(
                future: context
                    .read<EmployeeRepository>()
                    .getEmployeeRatingsWithEmployers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const EmployeeLoadingSkeleton();
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: EdgeInsets.all(28.w),
                      child: Center(
                          child: Text(
                        "Error while fetching feedback",
                        style: TextStyle(color: Colors.red.shade800),
                      )),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: Text(
                        "No Feedback yet!",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return EmployeeFeedbackList(ratings: snapshot.data!);
                  }
                })));
  }
}
