part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguageEvent extends SettingEvent {}

class LogoutEvent extends SettingEvent {}
