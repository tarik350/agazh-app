import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/screens/employee/widgets/other_detail/bloc/employee_other_detail_bloc.dart';
import 'package:mobile_app/screens/employee/widgets/other_detail/view/employee_other_detail_form.dart';

class EmployeeOtherDetailScreen extends StatelessWidget {
  const EmployeeOtherDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeOtherDetailBloc(
          employeeRepository: context.read<EmployeeRepository>()),
      child: const EmployeeOtherDetailForm(),
    );
  }
}
