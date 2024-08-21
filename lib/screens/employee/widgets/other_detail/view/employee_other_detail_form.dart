import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/config/constants/app_colors.dart';
import 'package:mobile_app/config/constants/app_config.dart';
import 'package:mobile_app/screens/employee/widgets/other_detail/bloc/employee_other_detail_bloc.dart';
import 'package:mobile_app/screens/employer_regisration/cubit/employer_registration_cubit.dart';
import 'package:mobile_app/utils/widgets/custom_button.dart';
import 'package:mobile_app/utils/widgets/custom_textfiled.dart';

class EmployeeOtherDetailForm extends StatelessWidget {
  const EmployeeOtherDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeOtherDetailBloc, EmployeeOtherDetailState>(
      listener: (context, state) {},
      child: SingleChildScrollView(
          child: Column(
        children: [
          const _WorkTypeDropDown(),
          const SizedBox(
            height: 12,
          ),
          const _ReligionDropdown(),
          const SizedBox(
            height: 12,
          ),
          // _ReligionInput(),
          // const SizedBox(
          //   height: 12,
          // ),
          _AgeInput(),
          const SizedBox(
            height: 12,
          ),
          _SubmitButton()
        ],
      )),
    );
  }
}

// class _ReligionInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<EmployeeOtherDetailBloc, EmployeeOtherDetailState>(
//       buildWhen: (previous, current) => previous.religion != current.religion,
//       builder: (context, state) {
//         return CustomTextfield(
//             hintText: 'other_detail.religion',
//             obscureText: false,
//             onChanged: (religion) => context
//                 .read<EmployeeOtherDetailBloc>()
//                 .add(ReligionChanged(religion)),
//             keyString: "otherDetail_religionInput_textField",
//             inputType: TextInputType.text,
//             errorText:
//                 state.religion.invalid ? state.religion.error?.message : null);
//       },
//     );
//   }
// }

class _AgeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeOtherDetailBloc, EmployeeOtherDetailState>(
      buildWhen: (previous, current) => previous.age != current.age,
      builder: (context, state) {
        return CustomTextfield(
            hintText: 'other_detail.age',
            obscureText: false,
            onChanged: (age) =>
                context.read<EmployeeOtherDetailBloc>().add(AgeChanged(age)),
            keyString: "otherDetail_ageInput_textField",
            inputType: TextInputType.text,
            errorText: state.age.isNotValid ? state.age.error?.message : null);
      },
    );
  }
}

class _WorkTypeDropDown extends StatelessWidget {
  const _WorkTypeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeOtherDetailBloc, EmployeeOtherDetailState>(
        builder: (context, state) {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          value: state.workType.isEmpty ? null : state.workType,
          onChanged: (value) => context
              .read<EmployeeOtherDetailBloc>()
              .add(WorkTypeChanged(value!)),
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
                      "other_detail.${AppConfig.toSnakeCase(item)}".tr(),
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

class _ReligionDropdown extends StatelessWidget {
  const _ReligionDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeOtherDetailBloc, EmployeeOtherDetailState>(
        builder: (context, state) {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          value: state.religion.isEmpty ? null : state.religion,
          onChanged: (value) => context
              .read<EmployeeOtherDetailBloc>()
              .add(ReligionChanged(value!)),
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
            'other_detail.religion'.tr(),
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: ["Orthodox", "Protestant", "Muslim", "Other"]
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      "other_detail.${AppConfig.toSnakeCase(item)}".tr(),
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

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeOtherDetailBloc, EmployeeOtherDetailState>(
      // listenWhen: (previous, current) =>
      //     previous.status != current.status ||
      //     previous.workType != current.workType,
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<EmployerRegistrationCubit>().stepContinued();
        }
      },
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.workType != current.workType ||
          previous.religion != current.religion,
      builder: (context, state) {
        return CustomButton(
          onTap: state.status.isSuccess &&
                  state.workType.isNotEmpty &&
                  state.religion.isNotEmpty
              ? () =>
                  context.read<EmployeeOtherDetailBloc>().add(FormSubmitted())
              : null,
          lable: state.status.isInProgress ? "loading".tr() : "proceed".tr(),
          backgroundColor: Colors.black,
        );
      },
    );
  }
}
