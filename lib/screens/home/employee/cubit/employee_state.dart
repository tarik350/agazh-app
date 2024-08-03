part of 'employee_cubit.dart';

class EmployeeState extends Equatable {
  final double rating;
  final FormzStatus status;
  final FormzStatus requestStatus;
  final String? errorMessage;
  const EmployeeState(
      {this.status = FormzStatus.pure,
      this.rating = 0.0,
      this.errorMessage,
      this.requestStatus = FormzStatus.pure});

  EmployeeState copyWith(
      {double? rating,
      FormzStatus? status,
      String? errorMessage,
      FormzStatus? requestStatus}) {
    return EmployeeState(
        rating: rating ?? this.rating,
        status: status ?? this.status,
        requestStatus: requestStatus ?? this.requestStatus,
        errorMessage: errorMessage);
  }

  @override
  List<Object> get props => [
        rating,
        requestStatus,
        status,
      ];
}
