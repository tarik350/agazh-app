part of 'employee_demography_bloc.dart';

abstract class EmployeeDemographyEvent extends Equatable {
  const EmployeeDemographyEvent();

  @override
  List<Object> get props => [];
}

class JobStatusChanged extends EmployeeDemographyEvent {
  final String status;

  const JobStatusChanged(this.status);
  @override
  List<Object> get props => [status];
}

class HouseNumberChanged extends EmployeeDemographyEvent {
  final String houseNumber;
  const HouseNumberChanged(this.houseNumber);

  @override
  List<Object> get props => [houseNumber];
}

class CityChanged extends EmployeeDemographyEvent {
  final String city;
  const CityChanged(this.city);

  @override
  List<Object> get props => [city];
}

class SubCityChanged extends EmployeeDemographyEvent {
  final String country;
  const SubCityChanged(this.country);

  @override
  List<Object> get props => [country];
}

class IdCardChanged extends EmployeeDemographyEvent {
  final String idCardImage;
  const IdCardChanged(this.idCardImage);

  @override
  List<Object> get props => [idCardImage];
}

class FormSubmitted extends EmployeeDemographyEvent {}
