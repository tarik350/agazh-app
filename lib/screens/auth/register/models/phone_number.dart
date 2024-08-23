import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  required('required'),
  invalid('phone_number_invalid');

  final String message;
  const PhoneNumberValidationError(this.message);
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  // Regex to match the different valid formats
  static final _phoneRegex = RegExp(
    r'^(09[0-9]{8}|07[0-9]{8}|251[0-9]{9}|\+251[0-9]{9}|9[0-9]{8}|7[0-9]{8})$',
  );

  // Convert the input to the standard format: +251 followed by the rest of the digits

  @override
  PhoneNumberValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneNumberValidationError.required;
    } else if (!_phoneRegex.hasMatch(value)) {
      return PhoneNumberValidationError.invalid;
    } else {
      return null;
    }
  }
}
