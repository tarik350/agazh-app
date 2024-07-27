import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/bloc/personal_info_bloc.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/view/personal_info_form.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const PersonalInfoScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalInfoBloc(
          employerRepositroy: context.read<EmployerRepositroy>(),
          userAuthDetailRepository: context.read<UserAuthDetailRepository>()),
      child: const PersonalInfoForm(),
    );
  }
}
