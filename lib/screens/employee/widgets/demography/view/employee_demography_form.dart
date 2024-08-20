import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/screens/employee/widgets/demography/bloc/employee_demography_bloc.dart';
import 'package:mobile_app/screens/employer_regisration/cubit/employer_registration_cubit.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/custom_textfiled.dart';

import '../../../../../config/constants/app_colors.dart';

class EmplyeeDemographyForm extends StatelessWidget {
  const EmplyeeDemographyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeDemographyBloc, EmployeeDemographyState>(
      listener: (context, state) {
        // if (state.status.isSubmissionFailure) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       const SnackBar(content: Text('Something went wrong!')),
        //     );
        // }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            _SalaryInput(),
            const SizedBox(
              height: 12,
            ),
            const _JobStatusDropDown(),
            const SizedBox(height: 12.0),
            _CityInput(),
            const SizedBox(height: 12.0),
            _SubCityInput(),
            const SizedBox(height: 12.0),
            _HouseNumberInput(),
            const SizedBox(height: 12.0),
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
    );
  }
}

class _HouseNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeDemographyBloc, EmployeeDemographyState>(
      buildWhen: (previous, current) =>
          previous.houseNumber != current.houseNumber,
      builder: (context, state) {
        return CustomTextfield(
            hintText: 'house_number',
            obscureText: false,
            onChanged: (houseNumber) => context
                .read<EmployeeDemographyBloc>()
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

class _CityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeDemographyBloc, EmployeeDemographyState>(
      buildWhen: (previous, current) => previous.city != current.city,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "city",
            obscureText: false,
            onChanged: (city) =>
                context.read<EmployeeDemographyBloc>().add(CityChanged(city)),
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
    return BlocBuilder<EmployeeDemographyBloc, EmployeeDemographyState>(
      buildWhen: (previous, current) => previous.subCity != current.subCity,
      builder: (context, state) {
        return CustomTextfield(
            hintText: "sub_city",
            obscureText: false,
            onChanged: (subCity) => context
                .read<EmployeeDemographyBloc>()
                .add(SubCityChanged(subCity)),
            keyString: "subCity_subCityInput_textField",
            inputType: TextInputType.text,
            errorText:
                state.subCity.invalid ? state.subCity.error?.message : null);
      },
    );
  }
}

class _SalaryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeDemographyBloc, EmployeeDemographyState>(
      buildWhen: (previous, current) => previous.salary != current.salary,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Salary: ${state.salary.value} ETB',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: state.salary.value.toDouble(),
              min: 0,
              max: 10000,
              divisions: 100,
              label: '${state.salary.value}',
              onChanged: (double newValue) {
                context
                    .read<EmployeeDemographyBloc>()
                    .add(SalaryChanged(newValue.toInt()));
              },
            ),
            if (state.salary.invalid)
              Text(
                state.salary.invalid ? state.salary.error!.message : "",
                style: const TextStyle(color: Colors.red),
              ),
          ],
        );
      },
    );
  }
}

// class _HouseNumberInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<EmployeeDemographyBloc, EmployeeDemographyState>(
//       buildWhen: (previous, current) => previous.country != current.country,
//       builder: (context, state) {
//         return CustomTextfield(
//             hintText: "House Number",
//             obscureText: false,
//             onChanged: (country) =>
//                 context.read<EmployeeDemographyBloc>().add(CountryChanged(country)),
//             keyString: "billingAddressForm_countryInput_textField",
//             inputType: TextInputType.text,
//             errorText:
//                 state.country.invalid ? state.country.error?.message : null);
//       },
//     );
//   }
// }

// class _FamilySizeInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<EmployeeDemographyBloc, EmployeeDemographyState>(
//       buildWhen: (previous, current) =>
//           previous.familySize != current.familySize,
//       builder: (context, state) {
//         return CustomTextfield(
//             hintText: "Family Size",
//             obscureText: false,
//             onChanged: (name) => context
//                 .read<EmployeeDemographyBloc>()
//                 .add(FamilySizeChanged(name)),
//             keyString: 'familySize_FamilySizeInput_textField',
//             inputType: TextInputType.number,
//             errorText: state.familySize.invalid
//                 ? state.familySize.error!.message
//                 : null);
//       },
//     );
//   }
// }

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeDemographyBloc, EmployeeDemographyState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.read<EmployerRegistrationCubit>().stepContinued();
        }
      },
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.jobStatus != current.jobStatus,
      builder: (context, state) {
        return CustomButton(
          onTap: state.status.isValidated &&
                  state.jobStatus != JobStatusEnum.none &&
                  state.status.isValid
              ? () =>
                  context.read<EmployeeDemographyBloc>().add(FormSubmitted())
              : null,
          lable: state.status.isSubmissionInProgress
              ? "loading".tr()
              : "proceed".tr(),
          backgroundColor: Colors.black,
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeDemographyBloc, EmployeeDemographyState>(
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

class _JobStatusDropDown extends StatelessWidget {
  const _JobStatusDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeDemographyBloc, EmployeeDemographyState>(
        builder: (context, state) {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          value: state.jobStatus == JobStatusEnum.none
              ? null
              : state.jobStatus.name == 'partTime'
                  ? "Part Time"
                  : "Full Time",
          onChanged: (String? value) => context
              .read<EmployeeDemographyBloc>()
              .add(JobStatusChanged(value!)),
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
      );
    });
  }
}
