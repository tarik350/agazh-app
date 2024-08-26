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

class GetEmployee extends HomeEvent {
  final String? filter;
  final String? name;

  const GetEmployee({this.filter, this.name});
}

class PINChanged extends HomeEvent {
  final String pin;
  const PINChanged(this.pin);

  @override
  List<Object> get props => [pin];
}

class ConfirmPinChanged extends HomeEvent {
  final String confirmPin;
  const ConfirmPinChanged(this.confirmPin);

  @override
  List<Object> get props => [confirmPin];
}

class ChangePasswordEvent extends HomeEvent {}
