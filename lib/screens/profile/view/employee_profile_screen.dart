import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/data/models/employee.dart';
import 'package:mobile_app/screens/employee/widgets/demography/bloc/employee_demography_bloc.dart';
import 'package:mobile_app/screens/profile/cubit/profile_cubit.dart';
import 'package:mobile_app/screens/profile/view/employer_profile_screen.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/utils/dialogue/error_dialogue.dart';
import 'package:mobile_app/utils/dialogue/success_dialogue.dart';
import 'package:shimmer/shimmer.dart';

import '../../../services/image_service.dart';

@RoutePage()
class EmployeeProfileScreen extends StatefulWidget {
  final Employee employee;
  const EmployeeProfileScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  final auth = FirebaseAuth.instance;
  late TextEditingController fullNameController;
  // late TextEditingController familySizeController;
  late TextEditingController cityController;
  late TextEditingController subCityController;
  late TextEditingController houseNumberController;
  late TextEditingController passwordController;
  late TextEditingController ageController;
  late TextEditingController religionController;
  String idCardPath = '';
  String profilePath = '';
  late String workType;
  late String jobStatus;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.employee.fullName);

    cityController = TextEditingController(text: widget.employee.city);
    subCityController = TextEditingController(text: widget.employee.subCity);
    houseNumberController =
        TextEditingController(text: widget.employee.houseNumber.toString());
    passwordController = TextEditingController(text: widget.employee.password);
    religionController = TextEditingController(text: widget.employee.religion);
    ageController = TextEditingController(text: widget.employee.age.toString());
    workType = widget.employee.workType;
    jobStatus = widget.employee.jobStatus == JobStatusEnum.partTime
        ? "partTime"
        : "fullTime";
  }

  void _updateProfile() {
    final updatedFields = <String, dynamic>{};

    if (fullNameController.text.isNotEmpty) {
      updatedFields['fullName'] = fullNameController.text;
    }

    if (cityController.text.isNotEmpty) {
      updatedFields['city'] = cityController.text;
    }
    if (subCityController.text.isNotEmpty) {
      updatedFields['subCity'] = subCityController.text;
    }
    if (houseNumberController.text.isNotEmpty) {
      updatedFields['houseNumber'] = int.parse(houseNumberController.text);
    }
    if (idCardPath.isNotEmpty) {
      updatedFields['idCardImagePath'] = idCardPath;
    }
    if (profilePath.isNotEmpty) {
      updatedFields['profilePicturePath'] = profilePath;
    }
    if (workType.isNotEmpty) {
      updatedFields['workType'] = workType;
    }
    if (jobStatus.isNotEmpty) {
      updatedFields['jobstatus'] = jobStatus;
    }
    if (passwordController.text.isNotEmpty) {
      updatedFields['password'] = passwordController.text;
    }
    if (ageController.text.isNotEmpty) {
      updatedFields['age'] = ageController.text;
    }
    if (religionController.text.isNotEmpty) {
      updatedFields['religion'] = religionController.text;
    }

    try {
      context.read<ProfileCubit>().updateProfile(
          auth.currentUser!.uid, updatedFields, UserRole.employee);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text(
            "profile".tr(),
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 23.sp,
              fontWeight: FontWeight.w600,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: CachedNetworkImage(
                        imageUrl: profilePath.isNotEmpty
                            ? profilePath
                            : widget.employee.profilePicturePath,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.secondaryColor,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: -10,
                      left: 55.w,
                      child: IconButton(
                          onPressed: () async {
                            Uint8List image =
                                await pickImage(ImageSource.gallery);

                            if (context.mounted) {
                              context.read<ProfileCubit>().uploadProfilePicture(
                                  file: image,
                                  path: "profilePics",
                                  id: widget.employee.id);
                            }
                          },
                          icon: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Container(
                              padding: EdgeInsets.all(4.r),
                              color: AppColors.primaryColor,
                              child: BlocBuilder<ProfileCubit, ProfileState>(
                                builder: (context, state) {
                                  if (state is ProfilePicutureUploading) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: SizedBox(
                                        height: 12.h,
                                        width: 12.w,
                                        child: CircularProgressIndicator(
                                          color: AppColors.whiteColor,
                                          strokeWidth: 2.w,
                                        ),
                                      ),
                                    );
                                  }
                                  return Icon(
                                    Icons.edit,
                                    size: 22.r,
                                    color: AppColors.whiteColor,
                                  );
                                },
                              ),
                            ),
                          )))
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              SizedBox(
                height: 12.h,
              ),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileUpdated) {
                    showSuccessDialog(context, "profile_success_message".tr());
                  }
                  if (state is ProfileUpdateError) {
                    showErrorDialog(context, "profile_error_message".tr());
                  }
                  if (state is IdCardUploaded) {
                    setState(() {
                      idCardPath = state.path;
                    });
                    showSuccessDialog(
                        context, "idcard_upload_success_message".tr());
                  }

                  if (state is ImageUploadError) {
                    showErrorDialog(
                        context, "idcard_upload_error_message".tr());
                  }
                  if (state is ProfilePictureUploaded) {
                    setState(() {
                      profilePath = state.path;
                    });
                    showSuccessDialog(
                        context, "profile_picture_success_message".tr());
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                      onTap: () async {
                        Uint8List image = await pickImage(ImageSource.gallery);
                        if (context.mounted) {
                          context
                              .read<ProfileCubit>()
                              .uploadIdCard(file: image, path: "idcard");
                        }
                      },
                      child: SizedBox(
                        width: double.infinity,
                        // decoration: const BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DottedBorder(
                              color: AppColors.primaryColor,
                              strokeWidth: 4.w,
                              strokeCap: StrokeCap.butt,
                              radius: Radius.circular(30.r),
                              child: state is IdCardUploading
                                  ? Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: SizedBox(
                                          width: 12.h,
                                          height: 12.w,
                                          child: CircularProgressIndicator(
                                            color: AppColors.primaryColor,
                                            strokeWidth: 4.w,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Column(children: [
                                        Icon(
                                          Icons.add,
                                          size: 30.h,
                                          color: AppColors.primaryColor,
                                        ),
                                        Text(
                                          "upload_id".tr(),
                                          style: const TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                    ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                          ],
                        ),
                      ));
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  value: workType.isNotEmpty ? workType : null,
                  onChanged: (value) => setState(() {
                    workType = value!;
                  }),
                  buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor.withOpacity(.3)))

                      // padding: EdgeInsets.symmetric(horizontal: 16),
                      // height: 40,
                      // width: 140,
                      ),
                  isExpanded: true,
                  hint: Text(
                    'other_detail.select_work_type'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: [
                    "Kitchen Staff",
                    "Cleaner",
                    "Full Time Housekeeper",
                    "Part Time Housekeeper",
                    "Nanny"
                  ]
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              "other_detail.${AppConfig.toSnakeCase(item)}"
                                  .tr(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  value: jobStatus.isEmpty
                      ? null
                      : jobStatus == 'partTime'
                          ? "Part Time"
                          : "Full Time",
                  onChanged: (String? value) => setState(() {
                    jobStatus = value == 'Part Time' ? "partTime" : "fullTime";
                  }),
                  buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor.withOpacity(.3)))),
                  isExpanded: true,
                  hint: Text(
                    'demography.select_job_status'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: ["Part Time", "Full Time"]
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              "demography.${AppConfig.toSnakeCase(item)}".tr(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              ProfileTextField(
                controller: fullNameController,
                labelText: 'full_name',
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 12.h,
              ),
              // ProfileTextField(
              //   controller: familySizeController,
              //   labelText: 'Family Size',
              //   keyboardType: TextInputType.number,
              // ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                controller: cityController,
                labelText: 'city',
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                controller: subCityController,
                labelText: 'sub_city',
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                controller: ageController,
                labelText: 'other_detail.age',
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                controller: religionController,
                labelText: 'other_detail.religion',
              ),

              SizedBox(
                height: 12.h,
              ),
              //work type

              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                controller: houseNumberController,
                labelText: 'house_number',
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                  controller: passwordController, labelText: 'pin'),
              const SizedBox(height: 20),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)))
                        .copyWith(backgroundColor:
                            MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return AppColors.primaryColor.withOpacity(.7);
                      } else {
                        return AppColors.primaryColor;
                      }
                    })).copyWith(),
                    onPressed: _updateProfile,
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(13.w),
                        child: Center(
                          child: state is ProfileUpdating
                              ? AppConfig.getProgressIndicatorNormal(
                                  color: AppColors.whiteColor)
                              : Text(
                                  'update'.tr(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
