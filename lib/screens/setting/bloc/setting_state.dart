part of 'setting_bloc.dart';

class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class Logout extends SettingState {}

class LogoutLoading extends SettingState {}

class LogoutError extends SettingState {
  final String message;

  const LogoutError(this.message);
}

class LanguageChange extends SettingState {}
