import 'dart:async';

import 'package:equatable/equatable.dart';
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
      final isUserExist = await _authService.checkUserExists(
          state.phoneNumber.value, event.role);
      if (isUserExist) {
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
    } on UserAlreadyExistException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }
}
