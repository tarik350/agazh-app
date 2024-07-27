// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mobile_app/buisness%20logic/services/auth_service.dart';
// import 'package:mobile_app/config/constants/app_colors.dart';

// @RoutePage()
// class RegisterScreen extends StatelessWidget {
//   RegisterScreen({super.key});
//   final nameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   final phoneController = TextEditingController();

//   @RoutePage()
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextFormField(
//                     controller: nameController,
//                     onChanged: (value) => {},
//                     decoration: const InputDecoration(
//                         hintText: 'Full name',
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(width: 2, color: Colors.red))),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'required';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(
//                     height: 12.h,
//                   ),
//                   TextFormField(
//                     controller: phoneController,
//                     onChanged: (value) => {},
//                     decoration: const InputDecoration(
//                         hintText: 'phone',
//                         border: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(width: 2, color: Colors.red))),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'required';
//                       }
//                       return null;
//                     },
//                   ),
//                   ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           // If the form is valid, display a snackbar. In the real world,
//                           // you'd often call a server or save the information in a database.
//                           AuthService().registerWithPhone(
//                               name: nameController.text,
//                               phone: phoneController.text,
//                               context: context);
//                         }
//                         // AuthService().phoneVerification(phoneController.text, context);

//                         print(phoneController.text);
//                       },
//                       child: const Text(
//                         "register",
//                         style: TextStyle(color: AppColors.primaryColor),
//                       ))
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }
