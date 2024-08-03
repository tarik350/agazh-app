import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/auth/register/models/Password.dart';
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
        employeeRepository.updatePassword(state.password.value);
        await employeeRepository.saveEmployee();
      } else {
        employerRepositroy.updatePassword(password: state.password.value);
        await employerRepositroy.saveEmployer();
      }
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionCanceled, errorMessage: e.toString()));
    }
  }

  void onPasswordChanged(String p) {
    final password = Password.dirty(p);
    emit(
        state.copyWith(password: password, status: Formz.validate([password])));
  }

  void onCheckBoxChange(bool isChecked) {
    emit(state.copyWith(isChecked: isChecked));
  }
}
