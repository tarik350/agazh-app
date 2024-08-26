import 'package:formz/formz.dart';

enum ConfirmPINValdiatorError {
  required("required"),
  invalid("does_not_match");

  final String message;

  const ConfirmPINValdiatorError(this.message);
}

class ConfirmPIN extends FormzInput<String, ConfirmPINValdiatorError> {
  final String password;

  const ConfirmPIN.pure({this.password = ''}) : super.pure('');

  const ConfirmPIN.dirty({required this.password, String value = ''})
      : super.dirty(value);

  @override
  ConfirmPINValdiatorError? validator(String value) {
    if (value.isEmpty) {
      return ConfirmPINValdiatorError.invalid;
    }

    return value.isEmpty
        ? ConfirmPINValdiatorError.required
        : password == value
            ? null
            : ConfirmPINValdiatorError.invalid;
  }
}
