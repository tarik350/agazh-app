part of 'terms_and_conditions_cubit.dart';

enum UserSubmissionStatus {
  pure,

  valid,

  /// The form contains one or more invalid inputs.
  invalid,

  /// The form is in the process of being submitted.
  inProgress,

  /// The form has been submitted successfully.
  success,

  /// The form submission failed.
  failure,

  /// The form submission has been canceled.
  submissionCanceled
}

class TermsAndConditionState extends Equatable {
  final bool isChecked;

  final String? errorMessage;
  final PIN pin;
  final ConfirmPIN confirmPin;
  final FormzSubmissionStatus status;

  const TermsAndConditionState({
    this.isChecked = false,
    this.errorMessage,
    this.pin = const PIN.pure(),
    this.confirmPin = const ConfirmPIN.pure(),
    this.status = FormzSubmissionStatus.initial,
  });
  TermsAndConditionState copyWith(
      {bool? isChecked,
      UserSubmissionStatus? userSubmissionStatus,
      PIN? pin,
      ConfirmPIN? confirmPin,
      FormzSubmissionStatus? status,
      String? errorMessage}) {
    return TermsAndConditionState(
        isChecked: isChecked ?? this.isChecked,
        errorMessage: errorMessage,
        status: status ?? this.status,
        pin: pin ?? this.pin,
        confirmPin: confirmPin ?? this.confirmPin);
  }

  @override
  List<Object> get props => [
        isChecked,
        pin,
        confirmPin,
        status,
      ];
}
