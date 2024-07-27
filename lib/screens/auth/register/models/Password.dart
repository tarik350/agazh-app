import 'package:formz/formz.dart';

enum PasswordValdiatorError {
  required("required");

  final String message;

  const PasswordValdiatorError(this.message);
}

class Password extends FormzInput<String, PasswordValdiatorError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValdiatorError? validator(String value) {
    return value.isNotEmpty ? null : PasswordValdiatorError.required;
  }
}
