import 'package:flutter/material.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class EmployeeLoadingSkeleton extends StatelessWidget {
  const EmployeeLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: AppColors.primaryColor.withOpacity(.3),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        // period: Duration(microseconds: 1000),
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        // period: Duration(microseconds: 1000),
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 200.0,
                          height: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    // period: Duration(microseconds: 1000),
                    child: Container(
                      width: double.infinity,
                      height: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    // period: Duration(microseconds: 1000),
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    // period: Duration(microseconds: 1000),
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100.0,
                      height: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular image placeholder
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          const SizedBox(width: 10.0),
          // Name placeholder
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150.0,
                height: 10.0,
                color: Colors.white,
              ),
              const SizedBox(height: 5.0),
              Container(
                width: 100.0,
                height: 10.0,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
