import 'package:formz/formz.dart';

enum FamilySizeValidator {
  required('Family can\'t be empty.'),
  invalid('Please provide a valid family size.');

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
