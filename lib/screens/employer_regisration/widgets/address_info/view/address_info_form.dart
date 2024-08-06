import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employer_regisration/cubit/employer_registration_cubit.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/bloc/address_info_bloc.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/custom_textfiled.dart';

class AddressInfoForm extends StatelessWidget {
  const AddressInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressInfoBloc, AddressInfoState>(
      listener: (context, state) {
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
          _CityInput(),
          const SizedBox(height: 12.0),
          _SubCityInput(),
          const SizedBox(height: 12.0),
          _SpecialLocaionInput(),
          const SizedBox(height: 12.0),
          _HouseNumberInput(),
          const SizedBox(height: 12.0),
          // _HouseNumberInput(),
          // // const SizedBox(height: 12.0),
          // _FamilySizeInput(),
          // const SizedBox(height: 12.0),
          //replace this with image uploader vierw
          _FamilySizeInput(),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(child: _SubmitButton()),
              const SizedBox(width: 8.0),
              Expanded(child: _CancelButton()),
            ],
          ),
        ],
      )),
    );
  }
}

class _HouseNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) =>
          previous.houseNumber != current.houseNumber,
      builder: (context, state) {
        return CustomTextfield(
            hintText: 'House Number',
            obscureText: false,
            onChanged: (houseNumber) => context
                .read<AddressInfoBloc>()
                .add(HouseNumberChanged(houseNumber)),
            keyString: "billingAddressForm_streetInput_textField",
            inputType: TextInputType.text,
            errorText: state.houseNumber.invalid
                ? state.houseNumber.error?.message
                : null);
      },
    );
  }
}

// class _FamilySizeInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddressInfoBloc, AddressInfoState>(
//       buildWhen: (previous, current) =>
//           previous.familySize != current.familySize,
//       builder: (context, state) {
//         return CustomTextfield(
//             hintText: "Family Size",
//             obscureText: false,
//             onChanged: (familySize) => context
//                 .read<AddressInfoBloc>()
//                 .add(FamilySizeChanged(familySize)),
//             keyString: "billingAddressForm_apartmentInput_textField",
//             inputType: TextInputType.text,
//             errorText: null);
//       },
//     );
//   }
// }

class _CityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) => previous.city != current.city,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "City",
            obscureText: false,
            onChanged: (city) =>
                context.read<AddressInfoBloc>().add(CityChanged(city)),
            keyString: "billingAddressForm_cityInput_textField",
            inputType: TextInputType.text,
            errorText: state.city.invalid ? state.city.error?.message : null);
      },
    );
  }
}

class _SubCityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) => previous.subCity != current.subCity,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "Sub City",
            obscureText: false,
            onChanged: (subCity) =>
                context.read<AddressInfoBloc>().add(SubCityChanged(subCity)),
            keyString: "subCity_subCityInput_textField",
            inputType: TextInputType.text,
            errorText:
                state.subCity.invalid ? state.subCity.error?.message : null);
      },
    );
  }
}

class _SpecialLocaionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) =>
          previous.specialLocation != current.specialLocation,
      builder: (context, state) {
        return CustomTextfield(
            maxLines: 3,
            hintText: "Special Locaion Description",
            obscureText: false,
            onChanged: (value) => context
                .read<AddressInfoBloc>()
                .add(SpecialLocaionChanged(value)),
            keyString: "specialLocaion_specialLocaionInput_textField",
            inputType: TextInputType.text,
            errorText: state.specialLocation.invalid
                ? state.specialLocation.error?.message
                : null);
      },
    );
  }
}

// class _HouseNumberInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddressInfoBloc, AddressInfoState>(
//       buildWhen: (previous, current) => previous.country != current.country,
//       builder: (context, state) {
//         return CustomTextfield(
//             hintText: "House Number",
//             obscureText: false,
//             onChanged: (country) =>
//                 context.read<AddressInfoBloc>().add(CountryChanged(country)),
//             keyString: "billingAddressForm_countryInput_textField",
//             inputType: TextInputType.text,
//             errorText:
//                 state.country.invalid ? state.country.error?.message : null);
//       },
//     );
//   }
// }

class _FamilySizeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) =>
          previous.familySize != current.familySize,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "Family Size",
            obscureText: false,
            onChanged: (name) =>
                context.read<AddressInfoBloc>().add(FamilySizeChanged(name)),
            keyString: 'familySize_FamilySizeInput_textField',
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
    return BlocConsumer<AddressInfoBloc, AddressInfoState>(
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
              ? () => context.read<AddressInfoBloc>().add(FormSubmitted())
              : null,
          lable:
              state.status.isSubmissionInProgress ? "Proceeding..." : "Proceed",
          backgroundColor: Colors.black,
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const SizedBox.shrink()
            : CustomButton(
                key:
                    const Key('billingAddressForm_cancelButton_elevatedButton'),
                onTap: () =>
                    context.read<EmployerRegistrationCubit>().stepCancelled(),
                lable: "Cancel",
                backgroundColor: Colors.red,
              );
      },
    );
  }
}
