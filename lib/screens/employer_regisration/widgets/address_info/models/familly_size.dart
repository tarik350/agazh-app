import 'package:formz/formz.dart';

enum FamilySizeValidator {
  required('required'),
  invalid('invalid_family_size');

  final String message;
  const FamilySizeValidator(this.message);
}

class FamilySize extends FormzInput<String, FamilySizeValidator> {
  const FamilySize.pure() : super.pure("");
  const FamilySize.dirty([String value = ""]) : super.dirty(value);
  static final RegExp _onlyNumbers = RegExp(r'^[1-9]\d*$');

  @override
  FamilySizeValidator? validator(String value) {
    return value.isEmpty
        ? FamilySizeValidator.required
        : _onlyNumbers.hasMatch(value)
            ? null
            : FamilySizeValidator.invalid;
  }
}
