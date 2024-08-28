import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/home/employer/cubit/employer_cubit.dart';
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
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _rating = widget.initialRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EmployerCubit(employerRepository: context.read<EmployerRepository>()),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'rate_title'.tr(),
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
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
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: 'feedback'.tr(),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'feedback_error_message'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                CustomButton(
                  padding: 12.h,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, {
                        'rating': _rating,
                        'feedback': _messageController.text
                      });
                    }
                  },
                  backgroundColor: AppColors.primaryColor,
                  lable: "submit".tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
