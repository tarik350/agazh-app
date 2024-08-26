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

enum ResendStatus { initial, failed, success }

class OtpState extends Equatable {
  final String otpString;
  final OtpStatus otpStringStatus;
  final OtpStatus otpSubmissionStatus;
  final bool isResendDisabled;
  final OtpStatus otpResendStatus;
  final String verificationId;
  final String countdown;
  final ResendStatus resendStatus;

  const OtpState(
      {this.otpString = '',
      this.otpStringStatus = OtpStatus.pure,
      this.otpSubmissionStatus = OtpStatus.pure,
      this.otpResendStatus = OtpStatus.pure,
      this.verificationId = '',
      this.resendStatus = ResendStatus.initial,
      this.countdown = '02:00',
      this.isResendDisabled = true});

  OtpState copyWith(
      {String? otpString,
      OtpStatus? otpStringStatus,
      bool? isResendDisabled,
      String? verificationId,
      OtpStatus? otpResendStatus,
      String? countdown,
      ResendStatus? resendStatus,
      OtpStatus? otpSubmissionStatus}) {
    return OtpState(
        otpString: otpString ?? this.otpString,
        otpResendStatus: otpResendStatus ?? this.otpResendStatus,
        verificationId: verificationId ?? this.verificationId,
        otpSubmissionStatus: otpSubmissionStatus ?? this.otpSubmissionStatus,
        isResendDisabled: isResendDisabled ?? this.isResendDisabled,
        countdown: countdown ?? this.countdown,
        resendStatus: resendStatus ?? this.resendStatus,
        otpStringStatus: otpStringStatus ?? this.otpStringStatus);
  }

  @override
  List<Object> get props => [
        otpString,
        otpSubmissionStatus,
        isResendDisabled,
        otpStringStatus,
        verificationId,
        countdown,
        otpResendStatus,
        resendStatus
      ];
}
