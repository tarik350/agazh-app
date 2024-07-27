import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/screens/auth/register/bloc/register_bloc.dart';
import 'package:mobile_app/screens/auth/register/view/register_form.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
              userAuthDetailRepository:
                  context.read<UserAuthDetailRepository>()),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
