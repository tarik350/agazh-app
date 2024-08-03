part of 'home_bloc.dart';

class HomeState extends Equatable {
  final FormzStatus requestDeleteStatus;
  final FormzStatus requestGetStatus;
  final List<Map<String, dynamic>>? requests;
  final int? deletingRequestIndex;
  final String? errorMessage;

  const HomeState({
    this.requests,
    this.errorMessage,
    this.requestGetStatus = FormzStatus.pure,
    this.requestDeleteStatus = FormzStatus.pure,
    this.deletingRequestIndex,
  });

  HomeState copyWith(
      {FormzStatus? requestDeleteStatus,
      int? deletingRequestIndex,
      List<Map<String, dynamic>>? requests,
      String? errorMessage,
      FormzStatus? requestGetStatus}) {
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
