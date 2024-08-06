part of 'employee_other_detail_bloc.dart';

sealed class EmployeeOtherDetailEvent extends Equatable {
  const EmployeeOtherDetailEvent();

  @override
  List<Object> get props => [];
}

class ReligionChanged extends EmployeeOtherDetailEvent {
  final String religion;

  const ReligionChanged(this.religion);
  @override
  List<Object> get props => [religion];
}

class AgeChanged extends EmployeeOtherDetailEvent {
  final String age;

  const AgeChanged(this.age);

  @override
  List<Object> get props => [age];
}

class FormSubmitted extends EmployeeOtherDetailEvent {}

class WorkTypeChanged extends EmployeeOtherDetailEvent {
  final String type;

  const WorkTypeChanged(this.type);
  @override
  List<Object> get props => [type];
}
