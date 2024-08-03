part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginFormSubmitted extends LoginEvent {}

class PhoneNumberChanged extends LoginEvent {
  final String phoneNumber;
  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class SelectedRoleChange extends LoginEvent {
  final String userRole;

  const SelectedRoleChange(this.userRole);
  @override
  List<Object> get props => [userRole];
}
