import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/auth/register/models/Password.dart';
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
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      if (role == UserRole.employee) {
        employeeRepository.updatePassword(state.pin.value);
        await employeeRepository.saveEmployee();
      } else {
        employerRepositroy.updatePassword(password: state.pin.value);
        await employerRepositroy.saveEmployer();
      }
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionCanceled, errorMessage: e.toString()));
    }
  }

  void onPinChanged(String p) {
    final pin = PIN.dirty(p);
    emit(state.copyWith(pin: pin, status: Formz.validate([pin])));
  }

  void onCheckBoxChange(bool isChecked) {
    emit(state.copyWith(isChecked: isChecked));
  }
}
