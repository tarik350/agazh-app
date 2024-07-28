import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/data/repository/employer_repository.dart';

import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/city.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/postcode.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/models/street.dart';

part 'address_info_event.dart';
part 'address_info_state.dart';

class AddressInfoBloc extends Bloc<AddressInfoEvent, AddressInfoState> {
  final EmployerRepositroy employerRepositroy;
  AddressInfoBloc({required this.employerRepositroy})
      : super(const AddressInfoState()) {
    on<HouseNumberChanged>(_onHouseNumberChanged);
    // on<FamilySizeChanged>(_onFamilySizeChanged);
    on<CityChanged>(_onCityChanged);
    // on<CountryChanged>(_onCountryChanged);
    on<IdCardChanged>(_onIdCardImageChanged);
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
        state.idCardIage,
      ]),
    ));
  }

  // void _onFamilySizeChanged(
  //   FamilySizeChanged event,
  //   Emitter<AddressInfoState> emit,
  // ) {
  //   final familySize = FamilySize.dirty(event.familySize);
  //   emit(state.copyWith(
  //     familySize: familySize,
  //     status: Formz.validate([
  //       state.familySize,
  //       familySize,
  //       state.city,
  //       state.houseNumber,
  //       state.idCardIage
  //     ]),
  //   ));
  // }

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
        state.idCardIage
      ]),
    ));
  }

  // void _onCountryChanged(
  //   CountryChanged event,
  //   Emitter<AddressInfoState> emit,
  // ) {
  //   final country = Country.dirty(event.country);
  //   emit(state.copyWith(
  //     country: country,
  //     status: Formz.validate([
  //       state.houseNumber,
  //       state.familySize,
  //       state.city,
  //       country,
  //       state.idCardIage
  //     ]),
  //   ));
  // }

  void _onIdCardImageChanged(
    IdCardChanged event,
    Emitter<AddressInfoState> emit,
  ) {
    final idCardIage = IdCardImage.dirty(event.idCardImage);
    emit(state.copyWith(
      idCardIage: idCardIage,
      status: Formz.validate([
        state.houseNumber,
        // state.familySize,
        state.city,
        state.idCardIage,
        idCardIage
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
        employerRepositroy.updateAddressInfo(
          houseNumber: state.houseNumber.value,
          city: state.city.value,
          // familySize: state.familySize.value,
          idCardImage: state.idCardIage.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
