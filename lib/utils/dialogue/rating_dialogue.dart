import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/screens/home/employee/cubit/employee_cubit.dart';
import 'package:mobile_app/services/init_service.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';

class RatingDialog extends StatefulWidget {
  final double initialRating;
  const RatingDialog({
    super.key,
    required this.initialRating,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  late double _rating;

  @override
  void initState() {
    _rating = widget.initialRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeCubit(context.read<EmployeeRepository>()),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Rate this user',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              RatingBar.builder(
                  itemSize: 30,
                  initialRating: _rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  }),
              const SizedBox(height: 20.0),

              CustomButton(
                padding: 12.h,
                onTap: () => Navigator.pop(context, _rating),
                lable: "Submit",
                backgroundColor: AppColors.primaryColor,
              )
              // ElevatedButton(
              //   onPressed: () {
              //     // Handle the rating submission logic here
              //     Navigator.pop(context, _rating);
              //   },
              //   child: const Text('Submit'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
