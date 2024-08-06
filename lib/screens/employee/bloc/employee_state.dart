part of 'employee_bloc.dart';

sealed class EmployerState extends Equatable {
  const EmployerState();

  @override
  List<Object> get props => [];
}

final class EmployeeInitial extends EmployerState {}
