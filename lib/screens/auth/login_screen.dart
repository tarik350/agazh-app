import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: phoneController,
                  onChanged: (value) => {},
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.red))),
                ),
                ElevatedButton(
                    onPressed: () {
                      // AuthService().phoneVerification(
                      //     phoneController.text, 'login', context);
                      print(phoneController.text);
                    },
                    child: const Text("login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
