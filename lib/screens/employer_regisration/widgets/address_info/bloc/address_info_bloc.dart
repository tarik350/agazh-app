import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/billing_address.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/familly_size.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/special_location.dart';

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
    on<SpecialLocaionChanged>(_onSpecialLocaionChanged);
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
        state.familySize,
        state.city,
      ])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.initial,
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
        state.subCity,
        familySize,
        state.city,
        state.houseNumber,
      ])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.initial,
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
      ])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.initial,
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
      ])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.initial,
    ));
  }

  FutureOr<void> _onSpecialLocaionChanged(
      SpecialLocaionChanged event, Emitter<AddressInfoState> emit) {
    final specialLocaion = SpecialLocaion.dirty(event.specialLocaion);
    emit(state.copyWith(
        specialLocation: specialLocaion,
        status: Formz.validate([
          specialLocaion,
          state.city,
          state.subCity,
          state.familySize,
          state.houseNumber
        ])
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.initial));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<AddressInfoState> emit,
  ) async {
    if (state.status.isSuccess) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        employerRepositroy.updateAddressInformation(
            houseNumber: int.parse(state.houseNumber.value),
            city: state.city.value,
            subCity: state.subCity.value,
            specialLocaion: state.specialLocation.value,
            familySize: int.parse(state.familySize.value));
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
