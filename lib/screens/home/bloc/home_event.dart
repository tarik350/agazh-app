part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class DeleteEmployeeRequest extends HomeEvent {
  final String employeId;
  final String employerId;
  final int index;

  const DeleteEmployeeRequest({
    required this.index,
    required this.employeId,
    required this.employerId,
  });

  @override
  List<Object> get props => [employeId, employerId, index];
}

class GetEmployeeRequest extends HomeEvent {}
