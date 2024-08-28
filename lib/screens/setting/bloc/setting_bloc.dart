import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final _auth = FirebaseAuth.instance;
  SettingBloc() : super(const SettingState()) {
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<LogoutEvent>(_onLogout);
  }

  FutureOr<void> _onChangeLanguage(
      ChangeLanguageEvent event, Emitter<SettingState> emit) {
    //todo logic for handling lanuage change
  }

  FutureOr<void> _onLogout(
      LogoutEvent event, Emitter<SettingState> emit) async {
    try {
      emit(LogoutLoading());
      await _auth.signOut();
      emit(Logout());
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }
}
