part of 'terms_and_conditions_cubit.dart';

enum UserSubmissionStatus {
  pure,

  valid,

  /// The form contains one or more invalid inputs.
  invalid,

  /// The form is in the process of being submitted.
  submissionInProgress,

  /// The form has been submitted successfully.
  submissionSuccess,

  /// The form submission failed.
  submissionFailure,

  /// The form submission has been canceled.
  submissionCanceled
}

class TermsAndConditionState extends Equatable {
  final bool isChecked;

  final String? errorMessage;
  final PIN pin;
  final FormzStatus status;

  const TermsAndConditionState({
    this.isChecked = false,
    this.errorMessage,
    this.pin = const PIN.pure(),
    this.status = FormzStatus.pure,
  });
  TermsAndConditionState copyWith(
      {bool? isChecked,
      UserSubmissionStatus? userSubmissionStatus,
      PIN? pin,
      FormzStatus? status,
      String? errorMessage}) {
    return TermsAndConditionState(
      isChecked: isChecked ?? this.isChecked,
      errorMessage: errorMessage,
      status: status ?? this.status,
      pin: pin ?? this.pin,
    );
  }

  @override
  List<Object> get props => [
        isChecked,
        pin,
        status,
      ];
}
