import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/screens/auth/register/models/Password.dart';
import 'package:mobile_app/screens/auth/register/models/phone_number.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/models/FullName.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/utils/exceptions/exceptions.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService = AuthService();
  RegisterBloc() : super(const RegisterState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<RegisterFormSubmitted>(_onFormSubmitted);
  }

  FutureOr<void> _onPhoneNumberChanged(
      PhoneNumberChanged event, Emitter<RegisterState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
        phoneNumber: phoneNumber, status: Formz.validate([phoneNumber])));
  }

  FutureOr<void> _onFormSubmitted(
      RegisterFormSubmitted event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final isEmplyerExist = await _authService.checkUserExists(
          state.phoneNumber.value, UserRole.employer);
      final isEmployeeExist = await _authService.checkUserExists(
          state.phoneNumber.value, UserRole.employee);

      if (isEmplyerExist || isEmployeeExist) {
        throw UserAlreadyExistException();
      }

      final String? verificationId =
          await _authService.phoneVerification(state.phoneNumber.value);

      if (verificationId != null) {
        emit(state.copyWith(
            status: FormzStatus.submissionSuccess,
            verificationId: verificationId));
      } else {
        throw VerificationIdNotReceivedException();
      }
    } on UserAlreadyExistException catch (_) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: "errors.user_already_exists".tr()));
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
    } on VerificationIdNotReceivedException catch (_) {
      final errorMessage = "verification_id_not_received".tr();
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: errorMessage));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }
}
