import 'package:formz/formz.dart';

enum FirstnameValidationError {
  required("required");

  final String message;

  const FirstnameValidationError(this.message);
}

class FirstName extends FormzInput<String, FirstnameValidationError> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty([String value = '']) : super.dirty(value);

  @override
  FirstnameValidationError? validator(String value) {
    return value.isNotEmpty ? null : FirstnameValidationError.required;
  }
}
