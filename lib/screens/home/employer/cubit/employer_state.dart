part of 'employer_cubit.dart';

class EmployerState extends Equatable {
  final double rating;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus requestStatus;
  final String? errorMessage;
  const EmployerState(
      {this.status = FormzSubmissionStatus.initial,
      this.rating = 0.0,
      this.errorMessage,
      this.requestStatus = FormzSubmissionStatus.initial});

  EmployerState copyWith(
      {double? rating,
      FormzSubmissionStatus? status,
      String? errorMessage,
      FormzSubmissionStatus? requestStatus}) {
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

class RequestErrorState extends EmployerState {}

class RatingErrorState extends EmployerState {}
