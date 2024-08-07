import 'package:formz/formz.dart';

enum PINValdiatorError {
  required("required"),
  invalid("invalid_pin");

  final String message;

  const PINValdiatorError(this.message);
}

class PIN extends FormzInput<String, PINValdiatorError> {
  const PIN.pure() : super.pure('');
  const PIN.dirty([String value = '']) : super.dirty(value);

  static final RegExp _numberRegex = RegExp(r'^\d{6}$');

  @override
  PINValdiatorError? validator(String value) {
    return value.isEmpty
        ? PINValdiatorError.required
        : _numberRegex.hasMatch(value)
            ? null
            : PINValdiatorError.invalid;
  }
}
