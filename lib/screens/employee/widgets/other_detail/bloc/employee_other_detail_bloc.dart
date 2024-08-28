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
    final validate = Formz.validate([age]);
    emit(state.copyWith(
        age: age,
        status: validate
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure));
  }

  FutureOr<void> _onReligionChanged(
      ReligionChanged event, Emitter<EmployeeOtherDetailState> emit) {
    emit(state.copyWith(religion: event.religion));
  }

  FutureOr<void> _onFormSubmitted(
      FormSubmitted event, Emitter<EmployeeOtherDetailState> emit) {
    if (state.status.isSuccess) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        employeeRepository.updateOtherDetails(
            age: int.parse(state.age.value),
            religion: state.religion,
            workType: state.workType);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  FutureOr<void> _onWorkTypeChanged(
      WorkTypeChanged event, Emitter<EmployeeOtherDetailState> emit) {
    emit(state.copyWith(workType: event.type));
  }
}
