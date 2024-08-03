// import 'package:formz/formz.dart';

// enum JobStatusValidator {
//   required('This field is required. Please fill up!'),
//   invalid("Invalid House number value");

//   final String message;
//   const JobStatusValidator(this.message);
// }

// class JobStatus extends FormzInput<String, JobStatusValidator> {
//   const JobStatus.pure() : super.pure('');
//   const JobStatus.dirty([String value = '']) : super.dirty(value);

//   static final RegExp _onlyNumbers = RegExp(r'^[1-9]\d*$');

//   @override
//   JobStatusValidator? validator(String value) {
//     return value.isEmpty
//         ? JobStatusValidator.required
//         : _onlyNumbers.hasMatch(value)
//             ? null
//             : JobStatusValidator.invalid;
//   }
// }
