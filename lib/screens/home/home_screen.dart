import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/init_service.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = getit<AuthService>().user;
    return const Scaffold(
      body: Center(child: Text("some thing ")),
    );
  }
}
