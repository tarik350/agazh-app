import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

class UserAuthDetail extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String password;
  final SelectedRole role;

  const UserAuthDetail(
      {required this.fullName,
      required this.phoneNumber,
      required this.role,
      required this.password});

  factory UserAuthDetail.empty() {
    return const UserAuthDetail(
        fullName: '',
        phoneNumber: "",
        role: SelectedRole.unknown,
        password: "");
  }

  UserAuthDetail copyWith({
    String? fullName,
    String? phoneNumber,
    String? password,
    SelectedRole? role,
  }) {
    final user = UserAuthDetail(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        fullName: fullName ?? this.fullName,
        password: password ?? this.password,
        role: role ?? this.role);
    return user;
  }

  factory UserAuthDetail.fromJson(Map<String, dynamic> json) {
    return UserAuthDetail(
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      role: json['role'].toString().toLowerCase() == 'employee'
          ? SelectedRole.employee
          : SelectedRole.employer,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'password': password,
      'role': role == SelectedRole.employee ? "employee" : "employer",
    };
  }

  @override
  List<Object?> get props => [fullName, password, phoneNumber, role];
}
