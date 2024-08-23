part of 'employer_cubit.dart';

class EmployerState extends Equatable {
  final double rating;
  final FormzStatus status;
  final FormzStatus requestStatus;
  final String? errorMessage;
  const EmployerState(
      {this.status = FormzStatus.pure,
      this.rating = 0.0,
      this.errorMessage,
      this.requestStatus = FormzStatus.pure});

  EmployerState copyWith(
      {double? rating,
      FormzStatus? status,
      String? errorMessage,
      FormzStatus? requestStatus}) {
    return EmployerState(
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

class RequestErrorState extends EmployerState {
  final String message;
  const RequestErrorState(this.message);
}

class RequestLoadingState extends EmployerState {}

class RequestSuccessState extends EmployerState {}

class RatingErrorState extends EmployerState {
  final String message;

  const RatingErrorState(this.message);
}

class RatingLoadingState extends EmployerState {}

class RatingSuccessState extends EmployerState {}
