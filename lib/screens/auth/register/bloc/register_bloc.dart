import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/auth_detail_repository.dart';
import 'package:mobile_app/screens/auth/register/models/FullName.dart';
import 'package:mobile_app/screens/auth/register/models/Password.dart';
import 'package:mobile_app/screens/auth/register/models/phone_number.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/utils/exceptions/exceptions.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserAuthDetailRepository userAuthDetailRepository;
  final AuthService _authService = AuthService();
  RegisterBloc({required this.userAuthDetailRepository})
      : super(const RegisterState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<FullNameChanged>(_onFullNameChanged);
    on<RegisterFormSubmitted>(_onFormSubmitted);
  }

  FutureOr<void> _onPasswordChanged(
      PasswordChanged event, Emitter<RegisterState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password,
        status: Formz.validate([password, state.fullName, state.phoneNumber])));
  }

  FutureOr<void> _onPhoneNumberChanged(
      PhoneNumberChanged event, Emitter<RegisterState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([phoneNumber, state.password, state.fullName])));
  }

  FutureOr<void> _onFullNameChanged(
      FullNameChanged event, Emitter<RegisterState> emit) {
    final fullName = FullName.dirty(event.fullName);
    emit(state.copyWith(
        fullName: fullName,
        status: Formz.validate([fullName, state.phoneNumber, state.password])));
  }

  FutureOr<void> _onFormSubmitted(
      RegisterFormSubmitted event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      // final String? verificationId =
      // await _authService.phoneVerification(state.phoneNumber.value);
      userAuthDetailRepository.initUserAuthDetail(
          fullName: state.fullName.value,
          password: state.password.value,
          phoneNumber: state.phoneNumber.value);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          verificationId: "verificationId"));
      // if (verificationId != null) {
      // } else {
      //   throw VerificationIdNotReceivedException();
      // }
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }
}
