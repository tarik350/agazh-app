import 'package:formz/formz.dart';

enum FullNameValidationError {
  required("required");

  final String message;

  const FullNameValidationError(this.message);
}

class FullName extends FormzInput<String, FullNameValidationError> {
  const FullName.pure() : super.pure('');
  const FullName.dirty([String value = '']) : super.dirty(value);

  @override
  FullNameValidationError? validator(String value) {
    return value.isNotEmpty ? null : FullNameValidationError.required;
  }
}
