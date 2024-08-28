import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/screens/employee/widgets/demography/bloc/employee_demography_bloc.dart';
import 'package:mobile_app/screens/employee/widgets/demography/view/employee_demography_form.dart';

class EmployeeDemographyScreen extends StatelessWidget {
  const EmployeeDemographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeDemographyBloc(
          employeeRepository: context.read<EmployeeRepository>()),
      child: const EmplyeeDemographyForm(),
    );
  }
}
