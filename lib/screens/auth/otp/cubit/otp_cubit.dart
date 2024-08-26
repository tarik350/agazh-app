import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/services/auth_service.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(
    this.otpStringLength,
  ) : super(const OtpState()) {
    _startTimer();
  }

  final int otpStringLength;
  final _authService = AuthService();
  Timer? _timer;

  void submitOptRequest(String verificationId) async {
    emit(state.copyWith(
      otpSubmissionStatus: OtpStatus.submissionInProgress,
    ));
    try {
      final response = await _authService.verifyOtp(
          state.otpString,
          state.verificationId.isNotEmpty
              ? state.verificationId
              : verificationId);
      if (response == true) {
        emit(state.copyWith(otpSubmissionStatus: OtpStatus.submissionSuccess));
      } else {
        emit(state.copyWith(otpSubmissionStatus: OtpStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(otpSubmissionStatus: OtpStatus.submissionFailure));
    }
  }

  void enableResend() {
    emit(state.copyWith(isResendDisabled: false));
  }

  void resendOtp(String phoneNumber) async {
    try {
      final String? verificationId =
          await _authService.phoneVerification(phoneNumber);
      if (verificationId != null) {
        emit(state.copyWith(
          resendStatus: ResendStatus.success,
          verificationId: verificationId,
        ));
        _restartTimer();
      } else {
        emit(state.copyWith(resendStatus: ResendStatus.failed));
        debugPrint("id is null");
      }
    } catch (e) {
      emit(state.copyWith(resendStatus: ResendStatus.failed));
      debugPrint(e.toString());
    }
  }

  void setOptString(String value) {
    emit(state.copyWith(otpString: value, otpStringStatus: OtpStatus.valid));
  }

  void changeOtpStringStatus() {
    emit(state.copyWith(otpStringStatus: OtpStatus.invalid));
  }

  void _startTimer() {
    // Set the initial countdown time (e.g., 2 minutes)
    int start = 120;
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start == 0) {
        timer.cancel();
        emit(state.copyWith(isResendDisabled: false, countdown: '00:00'));
      } else {
        start--;
        final minutes = (start / 60).floor().toString().padLeft(2, '0');
        final seconds = (start % 60).toString().padLeft(2, '0');
        emit(state.copyWith(countdown: '$minutes:$seconds'));
      }
    });
  }

  void _restartTimer() {
    emit(state.copyWith(
        isResendDisabled: true, resendStatus: ResendStatus.initial));
    _startTimer();
  }
}
