part of 'login_bloc.dart';

class LoginState extends Equatable {
  final PhoneNumber phoneNumber;
  // final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final PIN password;
  final String? verificationId;
  final UserRole userRole;

  const LoginState(
      {this.status = FormzStatus.pure,
      this.errorMessage,
      this.userRole = UserRole.none,
      this.password = const PIN.pure(),
      this.verificationId,
      this.phoneNumber = const PhoneNumber.pure()});

  LoginState copyWith(
      {PhoneNumber? phoneNumber,
      FormzStatus? status,
      String? errorMessage,
      PIN? password,
      UserRole? userRole,
      String? verificationId}) {
    //PROCESSED WITH OUT VERIFICATION ID FOR NOT
    //OTP IS DISABLED FOR NOT
    //LOGIN DIRECTLY REDIRECT TO HOME PAGE
    //UNCOMMENT THIS LINE TO ENABLE OTP

    // if (status == FormzStatus.success && verificationId == null) {
    //   throw VerificationIdNotReceivedException();
    // }

    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      userRole: userRole ?? this.userRole,
      password: password ?? this.password,
      errorMessage: status == FormzStatus.submissionFailure
          ? (errorMessage ?? this.errorMessage ?? 'Unknown error occured')
          : errorMessage ?? this.errorMessage,
      verificationId: verificationId ?? this.verificationId,
    );
  }

  @override
  List<dynamic> get props => [
        phoneNumber,
        status,
        errorMessage,
        userRole,
        password,
        verificationId,
      ];
}
