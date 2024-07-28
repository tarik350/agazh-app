import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/models/Employer.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employer_regisration/cubit/employer_registration_cubit.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/bloc/personal_info_bloc.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/terms_and_condition/cubit/termsandcondition_cubit.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployerRegistrationCubit, EmployerRegisrationState>(
      builder: (context, state) {
        final user = context.read<EmployerRepositroy>().getUser();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text('terms and conditions'),
              const _CustomHeader('Personal Information'),
              // _CustomText('Name', user.personalInfo.name),
              // _CustomText('Email', user.personalInfo.email),
              // _CustomText('Phone Number', user.personalInfo.phoneNumber),
              const SizedBox(height: 12.0),
              // const _CustomHeader('Billing Address'),
              // _CustomText('city', user.addressInfo.city),
              // _CustomText('family size', user.addressInfo.familySize),
              // _CustomText('house number', user.addressInfo.houseNumber),
              // _CustomText('id card image ', user.addressInfo.idCardImage),
              _CustomText(
                  "role",
                  user.userAuthDetail.role == SelectedRole.employee
                      ? "employee"
                      : "employer")
            ],
          ),
        );
      },
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomHeader extends StatelessWidget {
  const _CustomHeader(this.header);

  final String header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Text(
        header,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
