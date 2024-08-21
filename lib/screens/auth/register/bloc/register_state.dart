part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final PhoneNumber phoneNumber;
  // final Password password;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final String? verificationId;
  const RegisterState({
    // this.password = const Password.pure(),

    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.verificationId,
    this.phoneNumber = const PhoneNumber.pure(),
  });

  RegisterState copyWith(
      {FullName? fullName,
      Password? password,
      PhoneNumber? phoneNumber,
      FormzSubmissionStatus? status,
      String? errorMessage,
      String? verificationId}) {
    if (status == FormzSubmissionStatus.success && verificationId == null) {
      throw VerificationIdNotReceivedException();
    }

    return RegisterState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      errorMessage: status == FormzSubmissionStatus.failure
          ? (errorMessage ?? this.errorMessage ?? 'Unknown error occured')
          : errorMessage ?? this.errorMessage,
      verificationId: verificationId ?? this.verificationId,
      // password: password ?? this.password
    );
  }

  @override
  List<dynamic> get props => [
        phoneNumber,
        // password,
        status,
        errorMessage,
        verificationId
      ];
}
