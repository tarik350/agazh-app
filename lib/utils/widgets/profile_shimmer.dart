import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
