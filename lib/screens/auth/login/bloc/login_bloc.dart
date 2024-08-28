import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/screens/auth/register/models/Password.dart';
import 'package:mobile_app/screens/auth/register/models/phone_number.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/utils/exceptions/exceptions.dart';

import '../../../role/enums/selected_role.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _authService = AuthService();
  LoginBloc() : super(const LoginState()) {
    on<LoginFormSubmitted>(_onLogin);
    on<PhoneNumberChanged>(_onPhoneChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SelectedRoleChange>(_onSelectedRoleChange);
  }

  FutureOr<void> _onPhoneChanged(
      PhoneNumberChanged event, Emitter<LoginState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([phoneNumber, state.password])
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.initial));
  }

  FutureOr<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginState> emit) {
    final passwrod = Password.dirty(event.password);
    emit(state.copyWith(
        password: passwrod,
        status: Formz.validate([passwrod, state.phoneNumber])
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.initial));
  }

  FutureOr<void> _onLogin(
      LoginFormSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final employee = await _authService.lookupUser(
          state.phoneNumber.value, state.password.value, "employee");
      final employer = await _authService.lookupUser(
          state.phoneNumber.value, state.password.value, "employers");
      if (employee == null && employer == null) {
        throw UserDoesNotExist();
      }
      final String? verificationId =
          await _authService.phoneVerification(state.phoneNumber.value);

      if (verificationId != null) {
        emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            userRole: employee != null ? UserRole.employee : UserRole.employer,
            verificationId: verificationId));
      } else {
        throw VerificationIdNotReceivedException();
      }
    } on UserDoesNotExist catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onSelectedRoleChange(
      SelectedRoleChange event, Emitter<LoginState> emit) {
    if (event.userRole == 'employer') {
      final status = Formz.validate([state.password, state.phoneNumber]);

      emit(state.copyWith(
          userRole: UserRole.employer,
          status: Formz.validate([state.password, state.phoneNumber])
              ? FormzSubmissionStatus.success
              : FormzSubmissionStatus.initial));
    } else {
      final status = Formz.validate([state.password, state.phoneNumber]);

      emit(state.copyWith(
          userRole: UserRole.employee,
          status: Formz.validate([state.password, state.phoneNumber])
              ? FormzSubmissionStatus.success
              : FormzSubmissionStatus.initial));
    }
  }
}
