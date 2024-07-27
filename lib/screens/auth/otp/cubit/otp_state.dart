part of 'otp_cubit.dart';

enum OtpStatus {
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

class OtpState extends Equatable {
  final String otpString;
  final OtpStatus status;

  const OtpState({this.otpString = '', this.status = OtpStatus.pure});

  OtpState copyWith({String? otpString, OtpStatus? status}) {
    return OtpState(
        otpString: otpString ?? this.otpString, status: status ?? this.status);
  }

  @override
  List<Object> get props => [otpString, status];
}
