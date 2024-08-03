import 'package:formz/formz.dart';

enum HouseNumberValidator {
  required('This field is required. Please fill up!'),
  invalid("Invalid House number value");

  final String message;
  const HouseNumberValidator(this.message);
}

class HouseNumber extends FormzInput<String, HouseNumberValidator> {
  const HouseNumber.pure() : super.pure('');
  const HouseNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _onlyNumbers = RegExp(r'^[1-9]\d*$');

  @override
  HouseNumberValidator? validator(String value) {
    return value.isEmpty
        ? HouseNumberValidator.required
        : _onlyNumbers.hasMatch(value)
            ? null
            : HouseNumberValidator.invalid;
  }
}
