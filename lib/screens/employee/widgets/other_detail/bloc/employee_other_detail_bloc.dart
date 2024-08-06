import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/screens/employee/widgets/other_detail/models/age.dart';
import 'package:mobile_app/screens/employee/widgets/other_detail/models/religion.dart';

part 'employee_other_detail_event.dart';
part 'employee_other_detail_state.dart';

class EmployeeOtherDetailBloc
    extends Bloc<EmployeeOtherDetailEvent, EmployeeOtherDetailState> {
  final EmployeeRepository employeeRepository;
  EmployeeOtherDetailBloc({required this.employeeRepository})
      : super(const EmployeeOtherDetailState()) {
    on<AgeChanged>(_onAgeChanged);
    on<ReligionChanged>(_onReligionChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<WorkTypeChanged>(_onWorkTypeChanged);
  }

  FutureOr<void> _onAgeChanged(
      AgeChanged event, Emitter<EmployeeOtherDetailState> emit) {
    final age = Age.dirty(event.age);
    emit(state.copyWith(
        age: age, status: Formz.validate([age, state.religion])));
  }

  FutureOr<void> _onReligionChanged(
      ReligionChanged event, Emitter<EmployeeOtherDetailState> emit) {
    final religion = Religion.dirty(event.religion);
    emit(state.copyWith(
        religion: religion, status: Formz.validate([religion, state.age])));
  }

  FutureOr<void> _onFormSubmitted(
      FormSubmitted event, Emitter<EmployeeOtherDetailState> emit) {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        employeeRepository.updateOtherDetails(
            age: int.parse(state.age.value),
            religion: state.religion.value,
            workType: state.workType);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  FutureOr<void> _onWorkTypeChanged(
      WorkTypeChanged event, Emitter<EmployeeOtherDetailState> emit) {
    emit(state.copyWith(workType: event.type));
  }
}
