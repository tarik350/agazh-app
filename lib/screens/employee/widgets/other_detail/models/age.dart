import 'package:formz/formz.dart';

enum AgeValidator {
  required('required'),
  invalid("other_detail.invalid_age_value"),
  belowAge("other_detail.below_age_value");

  final String message;
  const AgeValidator(this.message);
}

class Age extends FormzInput<String, AgeValidator> {
  const Age.pure() : super.pure('');
  const Age.dirty([String value = '']) : super.dirty(value);
  static final RegExp _onlyNumbers = RegExp(r'^[1-9]\d*$');

  @override
  AgeValidator? validator(String value) {
    return value.isEmpty
        ? AgeValidator.required
        : _onlyNumbers.hasMatch(value)
            ? int.parse(value) < 18
                ? AgeValidator.belowAge
                : null
            : AgeValidator.invalid;
  }
}
