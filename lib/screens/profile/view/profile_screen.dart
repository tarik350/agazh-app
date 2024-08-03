import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/data/models/Employer.dart';
import 'package:mobile_app/screens/profile/view/cubit/profile_cubit.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/utils/dialogue/error_dialogue.dart';
import 'package:mobile_app/utils/dialogue/success_dialogue.dart';
import 'package:shimmer/shimmer.dart';

import '../../../services/image_service.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  final Employer employer;
  const ProfileScreen({Key? key, required this.employer}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  late TextEditingController fullNameController;
  late TextEditingController familySizeController;
  late TextEditingController cityController;
  late TextEditingController subCityController;
  late TextEditingController houseNumberController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.employer.fullName);
    familySizeController =
        TextEditingController(text: widget.employer.toString());
    cityController = TextEditingController(text: widget.employer.city);
    subCityController = TextEditingController(text: widget.employer.subCity);
    houseNumberController =
        TextEditingController(text: widget.employer.houseNumber.toString());
    passwordController = TextEditingController(text: widget.employer.password);
  }

  String idCardPath = '';
  String profilePath = '';

  void _updateProfile() {
    final updatedFields = <String, dynamic>{};

    if (fullNameController.text.isNotEmpty) {
      updatedFields['fullName'] = fullNameController.text;
    }
    if (familySizeController.text.isNotEmpty) {
      updatedFields['familySize'] = int.parse(familySizeController.text);
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
    if (passwordController.text.isNotEmpty) {
      updatedFields['password'] = passwordController.text;
    }

    try {
      context.read<ProfileCubit>().updateProfile(
          auth.currentUser!.uid, updatedFields, UserRole.employer);
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
            "Profile",
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
                            : widget.employer.profilePicturePath,
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
                                  file: image, path: "profilePics");
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
                    showSuccessDialog(
                        context, "Profile Information updated Successfully");
                  }
                  if (state is ProfileUpdateError) {
                    showErrorDialog(context,
                        "Error while uploading profile information: ${state.message} ");
                  }
                  if (state is IdCardUploaded) {
                    setState(() {
                      idCardPath = state.path;
                    });
                    showSuccessDialog(context, "Id Card uploaded successfully");
                  }

                  if (state is ImageUploadError) {
                    showErrorDialog(context, state.message);
                  }
                  if (state is ProfilePictureUploaded) {
                    setState(() {
                      profilePath = state.path;
                    });
                    showSuccessDialog(
                        context, "Profile picture uploaded successfully");
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
                                        const Text(
                                          "Update ID",
                                          style: TextStyle(
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
              ProfileTextField(
                controller: fullNameController,
                labelText: 'Full Name',
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                controller: familySizeController,
                labelText: 'Family Size',
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                controller: cityController,
                labelText: 'City',
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                controller: subCityController,
                labelText: 'Sub City',
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                controller: houseNumberController,
                labelText: 'House Number',
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 12.h,
              ),
              ProfileTextField(
                  controller: passwordController, labelText: 'Password'),
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
                              : const Text(
                                  'Update',
                                  style: TextStyle(
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

class EditProfileShimmer extends StatelessWidget {
  const EditProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           leading: IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: const Icon(Icons.arrow_back_ios),
//           ),
//           centerTitle: true,
//           title: Text(
//             "Profile",
//             style: TextStyle(
//               color: AppColors.primaryColor,
//               fontSize: 23.sp,
//               fontWeight: FontWeight.w600,
//             ),
//           )),
//       body: FutureBuilder(
//         future: context.read<EmployerRepository>().getEmployerData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const SingleChildScrollView(child: EditProfileShimmer());
//           }
//           if (snapshot.hasData) {
//             return SingleChildScrollView(
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     children: [
//                       Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(100.r),
//                             child: SizedBox(
//                               width: 100.w,
//                               height: 100.w,
//                               child: CachedNetworkImage(
//                                 imageUrl: snapshot.data!.profilePicturePath,
//                                 fit: BoxFit.cover,
//                                 errorWidget: (context, url, error) => Container(
//                                   color: AppColors.secondaryColor,
//                                   child: const Icon(
//                                     Icons.person,
//                                     color: AppColors.primaryColor,
//                                     size: 50,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                               bottom: -10,
//                               left: 55.w,
//                               child: IconButton(
//                                   onPressed: () {
//                                     // Uint8List image =
//                                     //     await pickImage(ImageSource.gallery);
//                                     // if (context.mounted) {
//                                     //   context.read<ProfileCubit>().add(
//                                     //       ProfilePictureChanged(
//                                     //           file: image, path: "profilePics"));
//                                   },
//                                   icon: ClipRRect(
//                                     borderRadius: BorderRadius.circular(100.r),
//                                     child: Container(
//                                       padding: EdgeInsets.all(4.r),
//                                       color: AppColors.primaryColor,
//                                       child: Icon(
//                                         Icons.edit,
//                                         size: 23.r,
//                                         color: AppColors.whiteColor,
//                                       ),
//                                     ),
//                                   )))
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       ...List.generate(5, (index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 20.0),
//                           child: CustomTextfield(
//                               hintText: "",
//                               obscureText: false,
//                               onChanged: (subCity) {},
//                               keyString: "",
//                               inputType: TextInputType.text,
//                               errorText: null),
//                         );
//                       }),
//                       CustomButton(
//                         onTap: () {},
//                         lable: "Update",
//                         backgroundColor: AppColors.primaryColor,
//                       ),
//                       // Padding(
//                       //   padding: EdgeInsets.only(
//                       //       bottom: MediaQuery.of(context).viewInsets.bottom),
//                       // )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//           if (snapshot.hasError) {}
//           return Container();
//         },
//       ),
//     );
//   }
// }

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;

  const ProfileTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(fontWeight: FontWeight.w300),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: AppColors.primaryColor.withOpacity(.1),
          filled: true,
          // hintText: hintText,
          // errorText: errorText,
          hintText: labelText,
          hintStyle: TextStyle(color: Colors.grey.shade500)),

      // decoration: InputDecoration(
      // ),
    );
  }
}
