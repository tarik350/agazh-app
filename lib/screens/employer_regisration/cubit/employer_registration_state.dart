part of 'employer_registration_cubit.dart';

class EmployerRegisrationState extends Equatable {
  const EmployerRegisrationState({
    this.activeStepperIndex = 0,
  });

  final int activeStepperIndex;

  EmployerRegisrationState copyWith({int? activeStepperIndex}) {
    return EmployerRegisrationState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
    );
  }

  @override
  List<Object> get props => [activeStepperIndex];
}
