part of 'home_bloc.dart';

class HomeState extends Equatable {
  final FormzSubmissionStatus requestDeleteStatus;
  final FormzSubmissionStatus requestGetStatus;
  final List<Map<String, dynamic>>? requests;
  final int? deletingRequestIndex;
  final String? errorMessage;

  const HomeState({
    this.requests,
    this.errorMessage,
    this.requestGetStatus = FormzSubmissionStatus.initial,
    this.requestDeleteStatus = FormzSubmissionStatus.initial,
    this.deletingRequestIndex,
  });

  HomeState copyWith(
      {FormzSubmissionStatus? requestDeleteStatus,
      int? deletingRequestIndex,
      List<Map<String, dynamic>>? requests,
      String? errorMessage,
      FormzSubmissionStatus? requestGetStatus}) {
    return HomeState(
      requestGetStatus: requestGetStatus ?? this.requestGetStatus,
      requests: requests,
      errorMessage: errorMessage,
      requestDeleteStatus: requestDeleteStatus ?? this.requestDeleteStatus,
      deletingRequestIndex: deletingRequestIndex,
    );
  }

  @override
  List<Object?> get props => [
        requestDeleteStatus,
        deletingRequestIndex,
        requestGetStatus,
        requests,
        errorMessage
      ];
}

class GetEmployeeLoading extends HomeState {}

class GetEmployeeLoaded extends HomeState {
  final List<Employee> employees;

  GetEmployeeLoaded(this.employees);
  @override
  List<Object?> get props => [employees];
}

class GetEmployeeError extends HomeState {
  final String message;

  GetEmployeeError(this.message);
  @override
  List<Object?> get props => [message];
}

class GetEmployeeEmpty extends HomeState {}

class GetEmployeeEmptyForFilter extends HomeState {
  final String filter;

  GetEmployeeEmptyForFilter(this.filter);
  @override
  List<Object?> get props => [filter];
}
