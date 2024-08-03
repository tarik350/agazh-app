import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/screens/employer_regisration/cubit/employer_registration_cubit.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/bloc/personal_info_bloc.dart';
import 'package:mobile_app/screens/role/cubit/role_cubit.dart';
import 'package:mobile_app/services/image_service.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/custom_textfiled.dart';

class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final state = context.read<PersonalInfoBloc>().state.name.value;
    return BlocListener<PersonalInfoBloc, PersonalInfoState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'Something went wrong!')),
            );
        }
        if (state.idCardUploadStatus == ImageUploadStatus.notUploaded) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content:
                      Text(state.errorMessage ?? "Id card is not uploaded")),
            );
        }
        // if (state.profilePictureUploadStatus == ImageUploadStatus.completed) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       const SnackBar(
        //           content: Text("Profile picture uploaded successfully")),
        //     );
        // }
        if (state.profilePictureUploadStatus == ImageUploadStatus.failed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text("Error ")),
            );
        }
      },
      child: Column(
        children: [
          const _ProfilePictureUploader(),
          const SizedBox(height: 20.0),
          _FullNameInput(),
          const SizedBox(height: 20.0),
          const _ImageUploaderButton(),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(child: _SubmitButton()),
              // const SizedBox(width: 8.0),
              // _CancelButton(),
            ],
          ),
        ],
      ),
    );
  }
}

// class _EmailInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
//       buildWhen: (previous, current) => previous.email != current.email,
//       builder: (context, state) {
//         return CustomTextfield(
//             hintText: "Email",
//             obscureText: false,
//             onChanged: (email) =>
//                 context.read<PersonalInfoBloc>().add(EmailChanged(email)),
//             keyString: "personalInfoForm_emailInput_textField",
//             inputType: TextInputType.emailAddress,
//             errorText: state.email.invalid ? state.email.error!.message : null);
//       },
//     );
//   }
// }

class _FullNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "Full Name",
            obscureText: false,
            onChanged: (name) =>
                context.read<PersonalInfoBloc>().add(FullNameChanged(name)),
            keyString: 'personalInfoForm_FullNameInput_textField',
            inputType: TextInputType.name,
            errorText:
                state.fullName.invalid ? state.fullName.error!.message : null);
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInfoBloc, PersonalInfoState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.read<EmployerRegistrationCubit>().stepContinued();
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CustomButton(
          onTap: state.status.isValidated
              ? () => context
                  .read<PersonalInfoBloc>()
                  .add(FormSubmitted(context.read<RoleCubit>().state.userRole))
              : null,
          lable:
              state.status.isSubmissionInProgress ? "Proceeding..." : "Proceed",
          backgroundColor: AppColors.primaryColor,
        );
      },
    );
  }
}

class _ImageUploaderButton extends StatelessWidget {
  const _ImageUploaderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      builder: (context, state) {
        return GestureDetector(
            onTap: () async {
              Uint8List image = await pickImage(ImageSource.gallery);
              if (context.mounted) {
                context
                    .read<PersonalInfoBloc>()
                    .add(IdCardChanged(file: image, path: "idcard"));
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
                    child: state.idCardUploadStatus != ImageUploadStatus.loading
                        ? Center(
                            child: Column(children: [
                              Icon(
                                Icons.add,
                                size: 30.h,
                                color: AppColors.primaryColor,
                              ),
                              const Text(
                                "Upload ID",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          )
                        : Padding(
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
                          ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  state.idCardUploadStatus == ImageUploadStatus.completed
                      ? Text(
                          "Image uploaded successfully",
                          style: TextStyle(
                              color: AppColors.succesColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp),
                        )
                      : Container()
                ],
              ),
            ));
      },
    );
  }
}

class _ProfilePictureUploader extends StatelessWidget {
  const _ProfilePictureUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      builder: (context, state) {
        return Stack(
          children: [
            state.profilePictureUploadStatus == ImageUploadStatus.completed
                ? CircleAvatar(
                    radius: 40.r,
                    backgroundImage:
                        NetworkImage(state.profilePicturePathString))
                // MemoryImage(state.profilePicturePathString))
                : CircleAvatar(
                    radius: 40.r,
                    backgroundColor: AppColors.secondaryColor,
                    child: state.profilePictureUploadStatus ==
                            ImageUploadStatus.loading
                        ? SizedBox(
                            width: 12.w,
                            height: 12.h,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              strokeWidth: 4.w,
                            ),
                          )
                        : const Icon(Icons.person)),
            Positioned(
                bottom: -10,
                left: 35.w,
                child: IconButton(
                    onPressed: () async {
                      Uint8List image = await pickImage(ImageSource.gallery);
                      if (context.mounted) {
                        context.read<PersonalInfoBloc>().add(
                            ProfilePictureChanged(
                                file: image, path: "profilePics"));
                      }
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 23.r,
                    )))
          ],
        );
      },
    );
  }
}

// class _CancelButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return state.status.isSubmissionInProgress
//             ? const SizedBox.shrink()
//             : TextButton(
//                 key: const Key('personalInfoForm_cancelButton_elevatedButton'),
//                 onPressed: () => context.read<EmployerRegistrationCubit>().stepCancelled(),
//                 child: const Text('CANCEL'),
//               );
//       },
//     );
//   }
// }
