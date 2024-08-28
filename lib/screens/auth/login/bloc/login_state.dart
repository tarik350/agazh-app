part of 'login_bloc.dart';

class LoginState extends Equatable {
  final PhoneNumber phoneNumber;
  // final Password password;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final Password password;
  final String? verificationId;
  final UserRole userRole;
  const LoginState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage,
      this.userRole = UserRole.none,
      this.password = const Password.pure(),
      this.verificationId,
      this.phoneNumber = const PhoneNumber.pure()});

  LoginState copyWith(
      {PhoneNumber? phoneNumber,
      FormzSubmissionStatus? status,
      String? errorMessage,
      Password? password,
      UserRole? userRole,
      String? verificationId}) {
    if (status == FormzSubmissionStatus.success && verificationId == null) {
      throw VerificationIdNotReceivedException();
    }

    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      userRole: userRole ?? this.userRole,
      password: password ?? this.password,
      errorMessage: status == FormzSubmissionStatus.failure
          ? (errorMessage ?? this.errorMessage ?? 'Unknown error occured')
          : errorMessage ?? this.errorMessage,
      verificationId: verificationId ?? this.verificationId,
      // password: password ?? this.password
    );
  }

  @override
  List<dynamic> get props =>
      [phoneNumber, status, errorMessage, userRole, password, verificationId];
}
