import 'package:formz/formz.dart';

enum SalaryValidatorError {
  invalid("Please provide a valid amount"),
  outOfRange("The value is out of range");

  final String message;

  const SalaryValidatorError(this.message);
}

class Salary extends FormzInput<int, SalaryValidatorError> {
  const Salary.pure() : super.pure(0); // Default to 0 for pure state
  const Salary.dirty([int value = 0]) : super.dirty(value);

  @override
  SalaryValidatorError? validator(int value) {
    return value == 0
        ? SalaryValidatorError.invalid
        : value < 0 || value > 10000
            ? SalaryValidatorError.outOfRange
            : null;
  }
}
