import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/screens/employer_regisration/cubit/employer_registration_cubit.dart';
import 'package:mobile_app/screens/employer_regisration/view/employer_stepper.dart';

@RoutePage()
class EmployerStepperScreen extends StatelessWidget {
  const EmployerStepperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<EmployerRegistrationCubit>(
        create: (_) => EmployerRegistrationCubit(3),
        child: const EmployerStepper(),
      ),
    );
  }
}
