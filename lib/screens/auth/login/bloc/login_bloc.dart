import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/screens/auth/register/models/phone_number.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/terms_and_condition/models/pin.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/init_service.dart';
import 'package:mobile_app/utils/exceptions/exceptions.dart';
import 'package:mobile_app/utils/helpers/helper.dart';

import '../../../role/enums/selected_role.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _authService = getit<AuthService>();

  LoginBloc() : super(const LoginState()) {
    on<LoginFormSubmitted>(_onLogin);
    on<PhoneNumberChanged>(_onPhoneChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SelectedRoleChange>(_onSelectedRoleChange);
  }

  FutureOr<void> _onPhoneChanged(
      PhoneNumberChanged event, Emitter<LoginState> emit) {
    final phoneNumber =
        PhoneNumber.dirty(normalizePhoneNumber(event.phoneNumber));
    emit(state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([phoneNumber, state.password])));
  }

  FutureOr<void> _onPasswordChanged(
      PasswordChanged event, Emitter<LoginState> emit) {
    final passwrod = PIN.dirty(event.password);
    emit(state.copyWith(
        password: passwrod,
        status: Formz.validate([passwrod, state.phoneNumber])));
  }

  FutureOr<void> _onLogin(
      LoginFormSubmitted event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final employee = await _authService.lookupUser(
          state.phoneNumber.value, state.password.value, "employee");
      final employer = await _authService.lookupUser(
          state.phoneNumber.value, state.password.value, "employers");
      if (employee == null && employer == null) {
        throw UserDoesNotExist();
      }

      //todo check user status

      if (employee != null && employee['status'] != 'active') {
        throw AccountNotActive("errors.account_not_active");
      }
      if (employer != null && employer['status'] != 'active') {
        throw AccountNotActive("errors.account_not_active");
      }

      // final String? verificationId =
      //     await _authService.phoneVerification(state.phoneNumber.value);

      // if (verificationId != null) {
      emit(state.copyWith(
        status: FormzStatus.success,
        userId: employee != null ? employee['id'] : employer!['id'],
        userRole: employee != null ? UserRole.employee : UserRole.employer,
        // verificationId: verificationId
      ));
      // } else {
      //   throw VerificationIdNotReceivedException();
      // }
    } on UserDoesNotExist catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } on AccountNotActive catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-phone-number':
          errorMessage = "phone_number_invalid".tr();
          break;
        case 'network-request-failed':
          errorMessage = "errors.network_request_failed".tr();
          break;
        case 'too-many-requests':
          errorMessage = "errors.too_many_requests".tr();
          break;
        case 'quota-exceeded':
          errorMessage = "errors.quota_exceeded".tr();
          break;
        default:
          errorMessage = "errors.unknown_error".tr();
          break;
      }
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: errorMessage));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onSelectedRoleChange(
      SelectedRoleChange event, Emitter<LoginState> emit) {
    if (event.userRole == 'employer') {
      emit(state.copyWith(
          userRole: UserRole.employer,
          status: Formz.validate([state.password, state.phoneNumber])));
    } else {
      emit(state.copyWith(
          userRole: UserRole.employee,
          status: Formz.validate([state.password, state.phoneNumber])));
    }
  }
}
