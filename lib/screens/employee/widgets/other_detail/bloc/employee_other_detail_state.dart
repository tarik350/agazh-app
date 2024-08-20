part of 'employee_other_detail_bloc.dart';

class EmployeeOtherDetailState extends Equatable {
  final String religion;
  final Age age;
  final FormzStatus status;
  final String workType;

  const EmployeeOtherDetailState(
      {this.age = const Age.pure(),
      this.workType = '',
      this.religion = '',
      this.status = FormzStatus.pure});

  EmployeeOtherDetailState copyWith(
      {String? religion, Age? age, FormzStatus? status, String? workType}) {
    return EmployeeOtherDetailState(
        status: status ?? this.status,
        age: age ?? this.age,
        workType: workType ?? this.workType,
        religion: religion ?? this.religion);
  }

  @override
  List<Object> get props => [age, religion, status, workType];
}
