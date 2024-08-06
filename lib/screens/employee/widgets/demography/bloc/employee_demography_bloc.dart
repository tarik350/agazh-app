import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/city.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/familly_size.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/house_number.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/sub_city.dart';

part 'employee_demography_event.dart';
part 'employee_demography_state.dart';

class EmployeeDemographyBloc
    extends Bloc<EmployeeDemographyEvent, EmployeeDemographyState> {
  final EmployeeRepository employeeRepository;

  EmployeeDemographyBloc({required this.employeeRepository})
      : super(const EmployeeDemographyState()) {
    on<HouseNumberChanged>(_onHouseNumberChanged);
    on<CityChanged>(_onCityChanged);
    on<SubCityChanged>(_onSubcityChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<JobStatusChanged>(_onJobStatusChangd);
  }

  void _onHouseNumberChanged(
    HouseNumberChanged event,
    Emitter<EmployeeDemographyState> emit,
  ) {
    final houseNumber = HouseNumber.dirty(event.houseNumber);
    emit(state.copyWith(
      houseNumber: houseNumber,
      status: Formz.validate([
        houseNumber,
        state.subCity,
        state.city,
      ]),
    ));
  }

  void _onJobStatusChangd(
    JobStatusChanged event,
    Emitter<EmployeeDemographyState> emit,
  ) {
    final jobStatus = event.status == 'Full Time'
        ? JobStatusEnum.fullTime
        : JobStatusEnum.partTime;
    emit(state.copyWith(
      jobStatus: jobStatus,
      status: Formz.validate([
        state.subCity,
        state.city,
        state.houseNumber,
      ]),
    ));
  }

  void _onCityChanged(
    CityChanged event,
    Emitter<EmployeeDemographyState> emit,
  ) {
    final city = City.dirty(event.city);
    emit(state.copyWith(
      city: city,
      status: Formz.validate([
        city,
        state.subCity,
        state.houseNumber,
      ]),
    ));
  }

  void _onSubcityChanged(
    SubCityChanged event,
    Emitter<EmployeeDemographyState> emit,
  ) {
    final subCity = SubCity.dirty(event.country);
    emit(state.copyWith(
      subCity: subCity,
      status: Formz.validate([
        state.houseNumber,
        state.city,
        subCity,
      ]),
    ));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<EmployeeDemographyState> emit,
  ) async {
    if (state.jobStatus == JobStatusEnum.none) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: "You have to select job status"));
      return;
    }

    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        employeeRepository.updateDemographyInformation(
            houseNumber: int.parse(state.houseNumber.value),
            city: state.city.value,
            subCity: state.subCity.value,
            jobStatus: state.jobStatus);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
