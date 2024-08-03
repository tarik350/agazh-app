import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/data/models/employee.dart';
import 'package:mobile_app/screens/home/bloc/home_bloc.dart';
import 'package:mobile_app/utils/dialogue/error_dialogue.dart';
import 'package:mobile_app/utils/dialogue/success_dialogue.dart';

// employee_request_list.dart
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
        Employee employee = request['employee'] as Employee;
        var status = request['status'];
        var timestamp = request['timestamp']?.toDate();

        // Format the timestamp to human-readable format
        String formattedDate = timestamp != null
            ? DateFormat('EEEE MMMM d, yyyy').format(timestamp)
            : 'N/A';

        // Define status background colors
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
          padding: const EdgeInsets.all(8.0),
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
                            imageUrl: employee.profilePicturePath ?? '',
                            progressIndicatorBuilder: (context, _, progress) =>
                                const Center(
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
                              employee.fullName ?? 'No Name',
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
                                    '${employee.city ?? 'No City'}, ${employee.subCity ?? 'No Subcity'}',
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
                            RatingBar.builder(
                              itemSize: 15,
                              initialRating:
                                  employee.totalRating.toDouble() ?? 0,
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
                              onRatingUpdate: (rating) {},
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                status.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Timestamp: $formattedDate',
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
                  child: BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {
                      if (state.requestDeleteStatus ==
                          FormzStatus.submissionSuccess) {
                        showSuccessDialog(
                            context, "Request Deleted successfully");
                      }
                      if (state.requestDeleteStatus ==
                          FormzStatus.submissionFailure) {
                        showErrorDialog(
                            context, "Error while deleting a request");
                      }
                    },
                    builder: (context, state) {
                      bool isDeleting = state.deletingRequestIndex == index &&
                          state.requestDeleteStatus ==
                              FormzStatus.submissionInProgress;

                      return TextButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(DeleteEmployeeRequest(
                              employeId: employee.id,
                              employerId: auth.currentUser!.uid,
                              index: index));
                          // context.read<HomeBloc>().add(GetEmployeeRequest());
                        },
                        child: isDeleting
                            ? AppConfig.getProgressIndicatorNormal(
                                color: AppColors.whiteColor)
                            : const Text(
                                'Delete Request',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
