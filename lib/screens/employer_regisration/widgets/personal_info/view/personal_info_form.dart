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
        print(state);
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            _FullNameInput(),
            // const SizedBox(height: 12.0),
            // _PhoneNumberInput(),
            const SizedBox(height: 20.0),
            _FamilySizeInput(),
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

class _FamilySizeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) =>
          previous.familySize != current.familySize,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "Family Size",
            obscureText: false,
            onChanged: (name) =>
                context.read<PersonalInfoBloc>().add(FamilySizeChanged(name)),
            keyString: 'familySize_FullNameInput_textField',
            inputType: TextInputType.number,
            errorText: state.familySize.invalid
                ? state.familySize.error!.message
                : null);
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
              ? () => context.read<PersonalInfoBloc>().add(FormSubmitted())
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
    return GestureDetector(
        onTap: () async {
          Uint8List image = await pickImage(ImageSource.gallery);
          if (context.mounted) {
            context
                .read<PersonalInfoBloc>()
                .add(IdCardChanged(file: image, path: "idcard."));
          }
        },
        child: SizedBox(
          width: double.infinity,
          // decoration: const BoxDecoration(),
          child: DottedBorder(
            color: AppColors.primaryColor,
            strokeWidth: 4.w,
            strokeCap: StrokeCap.butt,
            radius: Radius.circular(30.r),
            child: Center(
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
            ),
          ),
        ));
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
