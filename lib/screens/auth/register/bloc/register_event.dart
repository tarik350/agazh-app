part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends RegisterEvent {
  final String phoneNumber;
  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

// class PasswordChanged extends RegisterEvent {
//   final String password;
//   const PasswordChanged(this.password);
//   @override
//   List<Object> get props => [password];
// }

class RegisterFormSubmitted extends RegisterEvent {}
