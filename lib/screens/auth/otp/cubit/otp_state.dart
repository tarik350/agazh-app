part of 'otp_cubit.dart';

enum OtpStatus {
  pure,

  valid,

  /// The form contains one or more.isNotValid inputs.
 .isNotValid,

  /// The form is in the process of being submitted.
  inProgress,

  /// The form has been submitted successfully.
 . success,

  /// The form submission failed.
 . failure,

  /// The form submission has been canceled.
  submissionCanceled
}

class OtpState extends Equatable {
  final String otpString;
  final OtpStatus otpStringStatus;
  final OtpStatus otpSubmissionStatus;
  final bool isResendDisabled;
  final OtpStatus otpResendStatus;
  final String verificationId;

  const OtpState(
      {this.otpString = '',
      this.otpStringStatus = OtpStatus.pure,
      this.otpSubmissionStatus = OtpStatus.pure,
      this.otpResendStatus = OtpStatus.pure,
      this.verificationId = '',
      this.isResendDisabled = true});

  OtpState copyWith(
      {String? otpString,
      OtpStatus? otpStringStatus,
      bool? isResendDisabled,
      String? verificationId,
      OtpStatus? otpResendStatus,
      OtpStatus? otpSubmissionStatus}) {
    return OtpState(
        otpString: otpString ?? this.otpString,
        otpResendStatus: otpResendStatus ?? this.otpResendStatus,
        verificationId: verificationId ?? this.verificationId,
        otpSubmissionStatus: otpSubmissionStatus ?? this.otpSubmissionStatus,
        isResendDisabled: isResendDisabled ?? this.isResendDisabled,
        otpStringStatus: otpStringStatus ?? this.otpStringStatus);
  }

  @override
  List<Object> get props => [
        otpString,
        otpSubmissionStatus,
        isResendDisabled,
        otpStringStatus,
        verificationId,
        otpResendStatus
      ];
}
