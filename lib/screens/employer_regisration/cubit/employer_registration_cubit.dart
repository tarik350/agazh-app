import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employer_registration_state.dart';

class EmployerRegistrationCubit extends Cubit<EmployerRegisrationState> {
  EmployerRegistrationCubit(this.stepperLength)
      : super(const EmployerRegisrationState());
  final int stepperLength;

  void stepTapped(int tappedIndex) =>
      emit(EmployerRegisrationState(activeStepperIndex: tappedIndex));

  void stepContinued() {
    if (state.activeStepperIndex < stepperLength - 1) {
      emit(EmployerRegisrationState(
          activeStepperIndex: state.activeStepperIndex + 1));
    } else {
      emit(EmployerRegisrationState(
          activeStepperIndex: state.activeStepperIndex));
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      emit(EmployerRegisrationState(
          activeStepperIndex: state.activeStepperIndex - 1));
    } else {
      emit(EmployerRegisrationState(
          activeStepperIndex: state.activeStepperIndex));
    }
  }
}
