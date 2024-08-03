import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/billing_address.dart';

import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/city.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/familly_size.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/house_number.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/personal_info.dart';

part 'address_info_event.dart';
part 'address_info_state.dart';

class AddressInfoBloc extends Bloc<AddressInfoEvent, AddressInfoState> {
  final EmployerRepository employerRepositroy;
  AddressInfoBloc({required this.employerRepositroy})
      : super(const AddressInfoState()) {
    on<HouseNumberChanged>(_onHouseNumberChanged);
    on<FamilySizeChanged>(_onFamilySizeChanged);
    on<CityChanged>(_onCityChanged);
    on<SubCityChanged>(_onSubcityChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onHouseNumberChanged(
    HouseNumberChanged event,
    Emitter<AddressInfoState> emit,
  ) {
    final houseNumber = HouseNumber.dirty(event.houseNumber);
    emit(state.copyWith(
      houseNumber: houseNumber,
      status: Formz.validate([
        houseNumber,
        state.houseNumber,
        // state.familySize,
        state.city,
      ]),
    ));
  }

  void _onFamilySizeChanged(
    FamilySizeChanged event,
    Emitter<AddressInfoState> emit,
  ) {
    final familySize = FamilySize.dirty(event.familySize);
    emit(state.copyWith(
      familySize: familySize,
      status: Formz.validate([
        state.familySize,
        familySize,
        state.city,
        state.houseNumber,
      ]),
    ));
  }

  void _onCityChanged(
    CityChanged event,
    Emitter<AddressInfoState> emit,
  ) {
    final city = City.dirty(event.city);
    emit(state.copyWith(
      city: city,
      status: Formz.validate([
        // state.familySize,
        city,
        state.city,
        state.houseNumber,
      ]),
    ));
  }

  void _onSubcityChanged(
    SubCityChanged event,
    Emitter<AddressInfoState> emit,
  ) {
    final subCity = SubCity.dirty(event.country);
    emit(state.copyWith(
      subCity: subCity,
      status: Formz.validate([
        state.houseNumber,
        state.familySize,
        state.city,
        subCity,
      ]),
    ));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<AddressInfoState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        employerRepositroy.updateAddressInformation(
            houseNumber: int.parse(state.houseNumber.value),
            city: state.city.value,
            subCity: state.subCity.value,
            familySize: int.parse(state.familySize.value));
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
