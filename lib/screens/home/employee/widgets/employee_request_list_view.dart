import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/data/models/Employer.dart';

class EmployeeRequestList extends StatelessWidget {
  final List<Map<String, dynamic>> requests;
  final auth = FirebaseAuth.instance;

  EmployeeRequestList({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          var request = requests[index];
          Employer employer = request['employer'] as Employer;
          var status = request['status'];
          var timestamp = request['timestamp']?.toDate();
          String formattedDate = timestamp != null
              ? DateFormat('EEEE MMMM d, yyyy').format(timestamp)
              : 'N/A';
          Color statusColor;
          switch (status) {
            case 'approved':
              statusColor = Colors.green;
              break;
            case 'rejected':
              statusColor = Colors.red;
              break;
            case 'pending':
            default:
              statusColor = Colors.orange;
              break;
          }

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Card(
              elevation: 5,
              shadowColor: Colors.grey.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: employer.profilePicturePath ?? '',
                              progressIndicatorBuilder:
                                  (context, _, progress) => const Center(
                                      child: CircularProgressIndicator()),
                              errorWidget: (context, _, err) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                employer.fullName ?? 'No Name',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${employer.city ?? 'No City'}, ${employer.subCity ?? 'No Subcity'}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // RatingBar.builder(
                              //   itemSize: 15,
                              //   initialRating: employer.totalRating.toDouble() ?? 0,
                              //   minRating: 0,
                              //   direction: Axis.horizontal,
                              //   allowHalfRating: true,
                              //   itemCount: 5,
                              //   ignoreGestures: true,
                              //   itemPadding:
                              //       const EdgeInsets.symmetric(horizontal: 4.0),
                              //   itemBuilder: (context, _) => const Icon(
                              //     Icons.star,
                              //     color: Colors.amber,
                              //     size: 12,
                              //   ),
                              //   onRatingUpdate: (rating) {},
                              // ),
                              // const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  tr(status.toLowerCase()),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "time".tr(args: [formattedDate]),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
