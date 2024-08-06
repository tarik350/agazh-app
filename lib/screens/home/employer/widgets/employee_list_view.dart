import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/config/routes/app_routes.gr.dart';
import 'package:mobile_app/data/models/employee.dart';

class EmployeeProfileList extends StatelessWidget {
  final List<Employee> users;

  const EmployeeProfileList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        Employee user = users[index];
        return GestureDetector(
          onTap: () {
            print(user);
            context.router.push(EmployeeDetailRoute(employee: user));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedNetworkImage(
                          // width: 100,
                          // height: 100,
                          fit: BoxFit.cover,
                          imageUrl: user.profilePicturePath,
                          progressIndicatorBuilder: (context, _, progress) =>
                              AppConfig.getProgresIndicator(
                                  progress, AppColors.primaryColor),
                          errorWidget: (context, _, err) => Container(),
                        ),
                      ),
                      // child: Image.network(
                      //   user.profilePicturePath,
                      //   width: 100,
                      //   height: 100,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColors.primaryColor,
                              ),
                              Expanded(
                                child: Text(
                                  '${user.city ?? 'No City'}, ${user.subCity ?? 'No Subcity'}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Text(
                              //   '${user.city}, ${user.subCity}',
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     color: Colors.grey[700],
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          RatingBar.builder(
                            itemSize: 15,
                            initialRating: user.totalRating.toDouble(),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
