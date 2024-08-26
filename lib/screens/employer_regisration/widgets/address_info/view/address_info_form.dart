import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
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
              SnackBar(content: Text('unknown_error'.tr())),
            );
        }
      },
      child: Expanded(child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
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
                  _FamilySizeInput(),
                  const SizedBox(height: 12.0),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(child: _SubmitButton()),
                      const SizedBox(width: 8.0),
                      Expanded(child: _CancelButton()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}

// class _HouseNumberInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddressInfoBloc, AddressInfoState>(
//       buildWhen: (previous, current) =>
//           previous.houseNumber != current.houseNumber,
//       builder: (context, state) {
//         return CustomTextfield(
//             hintText: 'house_number',
//             obscureText: false,
//             onChanged: (houseNumber) => context
//                 .read<AddressInfoBloc>()
//                 .add(HouseNumberChanged(houseNumber)),
//             keyString: "billingAddressForm_streetInput_textField",
//             inputType: TextInputType.text,
//             errorText: state.houseNumber.invalid
//                 ? state.houseNumber.error?.message
//                 : null);
//       },
//     );
//   }
// }

class _HouseNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) =>
          previous.houseNumber != current.houseNumber ||
          previous.isNewHouseNumberSelected != current.isNewHouseNumberSelected,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextfield(
              hintText: 'house_number',
              obscureText: false,
              onChanged: (houseNumber) => context
                  .read<AddressInfoBloc>()
                  .add(HouseNumberChanged(houseNumber)),
              keyString: "billingAddressForm_streetInput_textField",
              inputType: TextInputType.text,
              errorText: state.houseNumber.invalid
                  ? state.houseNumber.error?.message
                  : null,
              // Disable input if 'new' is selected
              enabled: !state.isNewHouseNumberSelected,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Row(
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 30.h,
                    child: Checkbox(
                      // fillColor: WidgetStateProperty.all<Color>(
                      // AppColors.primaryColor),
                      activeColor: AppColors.primaryColor,
                      value: state.isNewHouseNumberSelected,
                      onChanged: (value) {
                        context
                            .read<AddressInfoBloc>()
                            .add(HouseNumberNewSelected(value!));
                        if (value == true) {
                          context
                              .read<AddressInfoBloc>()
                              .add(const HouseNumberChanged('new'));
                        } else {
                          context
                              .read<AddressInfoBloc>()
                              .add(const HouseNumberChanged(""));
                        }
                      },
                    ),
                  ),
                  Text(
                    'new'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) => previous.city != current.city,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "city",
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
            hintText: "sub_city",
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
            hintText: "special_location",
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
            hintText: "family_size",
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
          lable: state.status.isSubmissionInProgress
              ? "loading".tr()
              : "proceed".tr(),
          backgroundColor: AppColors.primaryColor,
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
                lable: "cancel".tr(),
                backgroundColor: Colors.red,
              );
      },
    );
  }
}
