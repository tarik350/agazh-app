import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/screens/employer_regisration/cubit/employer_registration_cubit.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/bloc/personal_info_bloc.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/custom_textfiled.dart';

class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<PersonalInfoBloc>().state.name.value;
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: BlocListener<PersonalInfoBloc, PersonalInfoState>(
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
              _EmailInput(),
              const SizedBox(height: 12.0),
              _NameInput(),
              const SizedBox(height: 12.0),
              _PhoneNumberInput(),
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
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "Email",
            obscureText: false,
            onChanged: (email) =>
                context.read<PersonalInfoBloc>().add(EmailChanged(email)),
            keyString: "personalInfoForm_emailInput_textField",
            inputType: TextInputType.emailAddress,
            errorText: state.email.invalid ? state.email.error!.message : null);
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "Name",
            obscureText: false,
            onChanged: (name) =>
                context.read<PersonalInfoBloc>().add(NameChanged(name)),
            keyString: 'personalInfoForm_nameInput_textField',
            inputType: TextInputType.name,
            errorText: state.name.invalid ? state.name.error!.message : null);
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return CustomTextfield(
            obscureText: false,
            inputType: TextInputType.phone,
            onChanged: (phone) =>
                context.read<PersonalInfoBloc>().add(PhoneNumberChanged(phone)),
            hintText: 'Phone',
            keyString: 'personalInfoForm_phoneNumberInput_textField',
            errorText: state.phoneNumber.invalid
                ? state.phoneNumber.error!.message
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
          backgroundColor: Colors.black,
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
