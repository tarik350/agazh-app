part of 'home_bloc.dart';

class HomeState extends Equatable {
  final FormzStatus requestDeleteStatus;
  final FormzStatus requestGetStatus;
  final List<Map<String, dynamic>>? requests;
  final int? deletingRequestIndex;
  final String? errorMessage;
  final FormzStatus changePinStatus;
  final PIN pin;
  final ConfirmPIN confirmPin;

  const HomeState({
    this.requests,
    this.errorMessage,
    this.requestGetStatus = FormzStatus.pure,
    this.requestDeleteStatus = FormzStatus.pure,
    this.deletingRequestIndex,
    this.changePinStatus = FormzStatus.pure,
    this.pin = const PIN.pure(),
    this.confirmPin = const ConfirmPIN.pure(),
  });

  HomeState copyWith(
      {FormzStatus? requestDeleteStatus,
      int? deletingRequestIndex,
      List<Map<String, dynamic>>? requests,
      String? errorMessage,
      FormzStatus? changePinStatus,
      PIN? pin,
      ConfirmPIN? confirmPin,
      FormzStatus? requestGetStatus}) {
    return HomeState(
        requestGetStatus: requestGetStatus ?? this.requestGetStatus,
        requests: requests,
        errorMessage: errorMessage,
        requestDeleteStatus: requestDeleteStatus ?? this.requestDeleteStatus,
        deletingRequestIndex: deletingRequestIndex,
        pin: pin ?? this.pin,
        changePinStatus: changePinStatus ?? this.changePinStatus,
        confirmPin: confirmPin ?? this.confirmPin);
  }

  @override
  List<Object?> get props => [
        requestDeleteStatus,
        deletingRequestIndex,
        requestGetStatus,
        requests,
        errorMessage,
        changePinStatus,
        pin,
        confirmPin
      ];
}

class GetEmployeeLoading extends HomeState {}

class GetEmployeeLoaded extends HomeState {
  final List<Employee> employees;

  const GetEmployeeLoaded(this.employees);
  @override
  List<Object?> get props => [employees];
}

class GetEmployeeError extends HomeState {
  final String message;

  const GetEmployeeError(this.message);
  @override
  List<Object?> get props => [message];
}

class GetEmployeeEmpty extends HomeState {}

class GetEmployeeEmptyForFilter extends HomeState {
  final String filter;

  const GetEmployeeEmptyForFilter(this.filter);
  @override
  List<Object?> get props => [filter];
}
