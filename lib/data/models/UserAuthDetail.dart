import 'package:equatable/equatable.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

class UserAuthDetail extends Equatable {
  final String phoneNumber;
  final String password;
  final UserRole role;

  const UserAuthDetail(
      {required this.phoneNumber, required this.role, required this.password});

  factory UserAuthDetail.empty() {
    return const UserAuthDetail(
        phoneNumber: "", role: UserRole.none, password: "");
  }

  UserAuthDetail copyWith({
    String? fullName,
    String? phoneNumber,
    String? password,
    UserRole? role,
  }) {
    final user = UserAuthDetail(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        role: role ?? this.role);
    return user;
  }

  factory UserAuthDetail.fromJson(Map<String, dynamic> json) {
    return UserAuthDetail(
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      role: json['role'].toString().toLowerCase() == 'employee'
          ? UserRole.employee
          : UserRole.employer,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
      'role': role == UserRole.employee ? "employee" : "employer",
    };
  }

  @override
  List<Object?> get props => [password, phoneNumber, role];
}
