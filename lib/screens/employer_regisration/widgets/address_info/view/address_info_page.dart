import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/bloc/address_info_bloc.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/view/address_info_form.dart';

class AddressInfoScreen extends StatelessWidget {
  const AddressInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressInfoBloc(
        employerRepositroy: context.read<EmployerRepository>(),
      ),
      child: const AddressInfoForm(),
    );
  }
}
