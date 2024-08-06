import 'package:formz/formz.dart';

enum ReligionValidator {
  required('This field is required. Please fill up!');
  // invalid("Invalid House number value");

  final String message;
  const ReligionValidator(this.message);
}

class Religion extends FormzInput<String, ReligionValidator> {
  const Religion.pure() : super.pure('');
  const Religion.dirty([String value = '']) : super.dirty(value);

  @override
  ReligionValidator? validator(String value) {
    return value.isEmpty ? ReligionValidator.required : null;
  }
}
