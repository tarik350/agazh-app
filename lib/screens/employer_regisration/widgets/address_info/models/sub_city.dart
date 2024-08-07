import 'package:formz/formz.dart';

enum SubCityValidator {
  required('required');

  final String message;
  const SubCityValidator(this.message);
}

class SubCity extends FormzInput<String, SubCityValidator> {
  const SubCity.pure() : super.pure('');
  const SubCity.dirty([String value = '']) : super.dirty(value);

  @override
  SubCityValidator? validator(String value) {
    return value.isNotEmpty ? null : SubCityValidator.required;
  }
}
