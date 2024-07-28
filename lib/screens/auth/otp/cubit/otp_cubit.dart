import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/services/auth_service.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.otpStringLength) : super(const OtpState());
  final int otpStringLength;
  final _authService = AuthService();

  void submitOptRequest(String verificationId) async {
    emit(state.copyWith(status: OtpStatus.submissionInProgress));
    try {
      final response =
          await _authService.verifyOtp(state.otpString, verificationId);
      if (response == true) {
        emit(state.copyWith(status: OtpStatus.submissionSuccess));
        //   // emit(OtpSuccessState());
      } else {
        //   // emit(OtpFailedState("Error verifying OTP"));
        emit(state.copyWith(status: OtpStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(status: OtpStatus.submissionFailure));
      // emit(OtpFailedState(e.toString()));
    }
  }

  void setOptString(String value) {
    emit(state.copyWith(otpString: value, status: OtpStatus.valid));
  }

  void onOtpStringChange(String value) {
    if (state.otpString.length != 6) {}
    // eit(state.copyWith(status: OtpStatus.invalid));
  }
}
