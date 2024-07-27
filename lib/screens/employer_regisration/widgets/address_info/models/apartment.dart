import 'package:formz/formz.dart';

class FamilySize extends FormzInput<String, void> {
  const FamilySize.pure() : super.pure('');
  const FamilySize.dirty([String value = '']) : super.dirty(value);

  @override
  void validator(String value) {}
}
