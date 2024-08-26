import 'package:formz/formz.dart';

enum HouseNumberValidator {
  required('required'),
  invalid("invalid_house_number");

  final String message;
  const HouseNumberValidator(this.message);
}

class HouseNumber extends FormzInput<String, HouseNumberValidator> {
  const HouseNumber.pure() : super.pure('');
  const HouseNumber.dirty({
    String value = '',
  }) : super.dirty(value);

  static final RegExp _onlyNumbersOrNew = RegExp(r'^(new|[1-9]\d*)$');

  @override
  HouseNumberValidator? validator(String value) {
    final isValidated = value.isEmpty
        ? HouseNumberValidator.required
        : _onlyNumbersOrNew.hasMatch(value)
            ? null
            : HouseNumberValidator.invalid;
    return isValidated;
  }

  // HouseNumber copyWith({String? value, bool? isEnabled}) {
  //   return HouseNumber.dirty(
  //     value: value ?? this.value,
  //     isEnabled: isEnabled ?? this.isEnabled,
  //   );
  // }
}
