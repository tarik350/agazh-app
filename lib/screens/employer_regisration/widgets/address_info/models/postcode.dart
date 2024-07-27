import 'package:formz/formz.dart';

enum PostcodeValidationError {
  required('Please provide ZIP / postcode.'),
  invalid('Invalid pincode. Try again!');

  final String message;
  const PostcodeValidationError(this.message);
}

class IdCardImage extends FormzInput<String, PostcodeValidationError> {
  const IdCardImage.pure() : super.pure('');
  const IdCardImage.dirty([String value = '']) : super.dirty(value);

  static final _postcodeRegex = RegExp(r"[0-9]{6}");

  @override
  PostcodeValidationError? validator(String value) {
    return value.isNotEmpty
        ? null
        // ? _postcodeRegex.hasMatch(value)
        //     ? null
        //     : PostcodeValidationError.invalid
        : PostcodeValidationError.required;
  }
}
