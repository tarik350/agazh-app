import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/services/auth_service.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(
    this.otpStringLength,
  ) : super(const OtpState());
  final int otpStringLength;
  final _authService = AuthService();

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
        //   // emit(OtpSuccessState());
      } else {
        //   // emit(OtpFailedState("Error verifying OTP"));
        emit(state.copyWith(otpSubmissionStatus: OtpStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(otpSubmissionStatus: OtpStatus.submissionFailure));
      // emit(OtpFailedState(e.toString()));
    }
  }

  void enableResend() {
    emit(state.copyWith(isResendDisabled: false));
  }

  void resendOtp() async {
    //todo b/c the only way to get that is from the role cubit  we need to send in the phone number
    // try {
    //   final String? verificationId = await _authService.phoneVerification(
    //       userAuthDetailRepository.getUserAuthDetail().phoneNumber);
    //   if (verificationId != null) {
    //     emit(state.copyWith(verificationId: verificationId));
    //   }
    // } catch (e) {
    //   //todo => error while resending otp
    //   debugPrint(e.toString());
    // }
  }

  void setOptString(String value) {
    emit(state.copyWith(otpString: value, otpStringStatus: OtpStatus.valid));
  }

  void changeOtpStringStatus() {
    emit(state.copyWith(otpStringStatus: OtpStatus.invalid));
  }
}
