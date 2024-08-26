import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employee_repository.dart';
import 'package:mobile_app/screens/employee/widgets/demography/models/salaray.dart';
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
    on<SalaryChanged>(_onSalaryChanged);
    on<DemographyHouseNumberNewSelected>(_onHouseNumberNewSelected);
  }

  void _onHouseNumberChanged(
    HouseNumberChanged event,
    Emitter<EmployeeDemographyState> emit,
  ) {
    final houseNumber = HouseNumber.dirty(
      value: event.houseNumber,
    );
    emit(state.copyWith(
      houseNumber: houseNumber,
      status: Formz.validate([
        houseNumber,
        state.salary,
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
        state.salary,
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
        state.salary,
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
      status: Formz.validate(
          [state.houseNumber, state.city, subCity, state.salary]),
    ));
  }

  FutureOr<void> _onSalaryChanged(
      SalaryChanged event, Emitter<EmployeeDemographyState> emit) {
    final salary = Salary.dirty(event.salary);
    emit(state.copyWith(
        salary: salary,
        status: Formz.validate(
            [state.houseNumber, state.city, state.subCity, salary])));
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

    if (state.status.isValid) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        employeeRepository.updateDemographyInformation(
            houseNumber: state.houseNumber.value,
            city: state.city.value,
            salaray: state.salary.value,
            subCity: state.subCity.value,
            jobStatus: state.jobStatus);
        emit(state.copyWith(status: FormzStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } else {
      debugPrint("");
    }
  }

  FutureOr<void> _onHouseNumberNewSelected(
      DemographyHouseNumberNewSelected event,
      Emitter<EmployeeDemographyState> emit) {
    emit(
      state.copyWith(isNewHouseNumberSelected: event.isNewSelected),
    );
  }
}
