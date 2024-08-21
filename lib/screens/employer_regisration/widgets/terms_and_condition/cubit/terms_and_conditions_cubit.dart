import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/auth/register/models/Password.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/terms_and_condition/models/confirm_pin.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/terms_and_condition/models/pin.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';

part 'termsandcondition_state.dart';

class TermsandconditionCubit extends Cubit<TermsAndConditionState> {
  final EmployerRepository employerRepositroy;
  final EmployeeRepository employeeRepository;
  TermsandconditionCubit.TermsAndConditionCubit(
      {required this.employerRepositroy, required this.employeeRepository})
      : super(const TermsAndConditionState());

  void saveUser(UserRole role) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      if (role == UserRole.employee) {
        employeeRepository.updatePassword(state.pin.value);
        await employeeRepository.saveEmployee();
      } else {
        employerRepositroy.updatePassword(password: state.pin.value);
        await employerRepositroy.saveEmployer();
      }
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.submissionCanceled,
          errorMessage: e.toString()));
    }
  }

  void onPinChanged(String p) {
    final pin = PIN.dirty(p);
    final confirmPin = state.confirmPin.pure
        ? state.confirmPin
        : ConfirmPIN.dirty(password: p, value: state.confirmPin.value);

    emit(state.copyWith(
      pin: pin,
      confirmPin: confirmPin, // Update confirm pin only if it's dirty
      status: Formz.validate([pin, confirmPin]),
    ));
  }

  void onConfirmPinChanged(String p) {
    final confirmPin = ConfirmPIN.dirty(password: state.pin.value, value: p);

    emit(state.copyWith(
      confirmPin: confirmPin,
      status: Formz.validate([state.pin, confirmPin]),
    ));
  }

  void onCheckBoxChange(bool isChecked) {
    emit(state.copyWith(isChecked: isChecked));
  }
}
