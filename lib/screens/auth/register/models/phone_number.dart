import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  required('Phone Number can\'t be empty.'),
  invalid('The phone number is invalid.');

  final String message;
  const PhoneNumberValidationError(this.message);
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final _phoneRegex = RegExp(r"^\+251[0-9]{9}$");
  // static final _phoneRegex = RegExp(r"^\+251[97][0-9]{9}$");

  @override
  PhoneNumberValidationError? validator(String value) {
    return value.isEmpty ? PhoneNumberValidationError.required : null;
    // : _phoneRegex.hasMatch(value)
    //     ? null
    //     : PhoneNumberValidationError.invalid;
  }
}
