import 'package:formz/formz.dart';

enum SpecialLocaionValidationError {
  required('required');

  final String message;
  const SpecialLocaionValidationError(this.message);
}

class SpecialLocaion extends FormzInput<String, SpecialLocaionValidationError> {
  const SpecialLocaion.pure() : super.pure('');
  const SpecialLocaion.dirty([String value = '']) : super.dirty(value);

  @override
  SpecialLocaionValidationError? validator(String value) {
    return value.isNotEmpty ? null : SpecialLocaionValidationError.required;
  }
}
