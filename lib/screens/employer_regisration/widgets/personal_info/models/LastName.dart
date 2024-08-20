import 'package:formz/formz.dart';

enum LastnameValidationError {
  required("required");

  final String message;

  const LastnameValidationError(this.message);
}

class LastName extends FormzInput<String, LastnameValidationError> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([String value = '']) : super.dirty(value);

  @override
  LastnameValidationError? validator(String value) {
    return value.isNotEmpty ? null : LastnameValidationError.required;
  }
}
