part of 'employee_demography_bloc.dart';

enum JobStatusEnum { fullTime, partTime, none }

class EmployeeDemographyState extends Equatable {
  const EmployeeDemographyState(
      {this.houseNumber = const HouseNumber.pure(),
      this.city = const City.pure(),
      this.familySize = const FamilySize.pure(),
      this.subCity = const SubCity.pure(),
      this.status = FormzStatus.pure,
      this.salary = const Salary.pure(),
      this.errorMessage,
      this.isNewHouseNumberSelected = false,
      this.jobStatus = JobStatusEnum.none});

  final HouseNumber houseNumber;
  final FamilySize familySize;
  final City city;
  final FormzStatus status;
  final JobStatusEnum jobStatus;
  final SubCity subCity;
  final String? errorMessage;
  final Salary salary;
  final bool isNewHouseNumberSelected;

  EmployeeDemographyState copyWith(
      {HouseNumber? houseNumber,
      FamilySize? familySize,
      City? city,
      SubCity? subCity,
      JobStatusEnum? jobStatus,
      String? errorMessage,
      FormzStatus? status,
      Salary? salary,
      bool? isNewHouseNumberSelected,
      String? workType}) {
    return EmployeeDemographyState(
        houseNumber: houseNumber ?? this.houseNumber,
        familySize: familySize ?? this.familySize,
        city: city ?? this.city,
        subCity: subCity ?? this.subCity,
        status: status ?? this.status,
        errorMessage: errorMessage,
        salary: salary ?? this.salary,
        isNewHouseNumberSelected:
            isNewHouseNumberSelected ?? this.isNewHouseNumberSelected,
        jobStatus: jobStatus ?? this.jobStatus);
  }

  @override
  List<Object> get props => [
        houseNumber,
        subCity,
        jobStatus,
        city,
        familySize,
        status,
        salary,
        isNewHouseNumberSelected
      ];
}
