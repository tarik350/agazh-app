import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
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
    return BlocListener<PersonalInfoBloc, PersonalInfoState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'unknown_error'.tr())),
            );
        }
        if (state.idCardUploadStatusFront == ImageUploadStatus.notUploaded) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ??
                      "idcard_upload_error_message".tr())),
            );
        }
        if (state.idCardUploadStatusBack == ImageUploadStatus.notUploaded) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ??
                      "idcard_upload_error_message".tr())),
            );
        }

        if (state.profilePictureUploadStatus == ImageUploadStatus.failed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("idcard_upload_error_message".tr())),
            );
        }
      },
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _ProfilePictureUploader(),
              const SizedBox(height: 20.0),
              _FirstNameInput(),
              const SizedBox(height: 20.0),
              _LastNameInput(),
              const SizedBox(height: 20.0),
              const _IDCardUploadFront(),
              const SizedBox(height: 20.0),
              const _IDCardUploadBack(),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(child: _SubmitButton()),
                ],
              ),
            ],
          ),
        ),
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

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "firstname".tr(),
            obscureText: false,
            onChanged: (name) =>
                context.read<PersonalInfoBloc>().add(FirstNameChanged(name)),
            keyString: 'personalInfoForm_FirstNameInput_textField',
            inputType: TextInputType.name,
            errorText: state.firstName.invalid
                ? state.firstName.error!.message
                : null);
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "lastname".tr(),
            obscureText: false,
            onChanged: (name) =>
                context.read<PersonalInfoBloc>().add(LastNameChanged(name)),
            keyString: 'personalInfoForm_LastNameInput_textField',
            inputType: TextInputType.name,
            errorText:
                state.lastName.invalid ? state.lastName.error!.message : null);
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
          lable: state.status.isSubmissionInProgress
              ? "loading".tr()
              : "proceed".tr(),
          backgroundColor: AppColors.primaryColor,
        );
      },
    );
  }
}

class _IDCardUploadFront extends StatelessWidget {
  const _IDCardUploadFront({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      builder: (context, state) {
        return GestureDetector(
            onTap: () async {
              final image = await showImageSourceDialog(context);
              if (image != null && context.mounted) {
                context
                    .read<PersonalInfoBloc>()
                    .add(IdCardChangedFront(file: image, path: "idcard"));
              } else {
                //todo => Handle the case where no image was picked (optional)
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DottedBorder(
                    color: AppColors.primaryColor,
                    strokeWidth: 4.w,
                    strokeCap: StrokeCap.butt,
                    radius: Radius.circular(30.r),
                    child: state.idCardUploadStatusFront !=
                            ImageUploadStatus.loading
                        ? Center(
                            child: Column(children: [
                              Icon(
                                Icons.add,
                                size: 30.h,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                "upload_id_front".tr(),
                                style: const TextStyle(
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
                  state.idCardUploadStatusFront == ImageUploadStatus.completed
                      ? Text(
                          "idcard_upload_success_message".tr(),
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

class _IDCardUploadBack extends StatelessWidget {
  const _IDCardUploadBack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      builder: (context, state) {
        return GestureDetector(
            onTap: () async {
              final image = await showImageSourceDialog(context);
              if (image != null && context.mounted) {
                context
                    .read<PersonalInfoBloc>()
                    .add(IdCardChangedBack(file: image, path: "idcard"));
              } else {
                //todo => Handle the case where no image was picked (optional)
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DottedBorder(
                    color: AppColors.primaryColor,
                    strokeWidth: 4.w,
                    strokeCap: StrokeCap.butt,
                    radius: Radius.circular(30.r),
                    child: state.idCardUploadStatusBack !=
                            ImageUploadStatus.loading
                        ? Center(
                            child: Column(children: [
                              Icon(
                                Icons.add,
                                size: 30.h,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                "upload_id_back".tr(),
                                style: const TextStyle(
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
                  state.idCardUploadStatusBack == ImageUploadStatus.completed
                      ? Text(
                          "idcard_upload_success_message".tr(),
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
                      final image = await showImageSourceDialog(context);
                      if (context.mounted && image != null) {
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
