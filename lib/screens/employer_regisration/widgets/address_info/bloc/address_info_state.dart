part of 'address_info_bloc.dart';

class AddressInfoState extends Equatable {
  const AddressInfoState(
      {this.city = const City.pure(),
      this.familySize = const FamilySize.pure(),
      this.subCity = const SubCity.pure(),
      this.status = FormzStatus.pure,
      this.houseNumber = const HouseNumber.pure(),
      this.isNewHouseNumberSelected = false,
      this.specialLocation = const SpecialLocaion.pure()});

  final HouseNumber houseNumber;
  final FamilySize familySize;
  final City city;
  final FormzStatus status;
  final SubCity subCity;
  final SpecialLocaion specialLocation;
  final bool isNewHouseNumberSelected;

  AddressInfoState copyWith({
    FamilySize? familySize,
    City? city,
    SubCity? subCity,
    SpecialLocaion? specialLocation,
    FormzStatus? status,
    HouseNumber? houseNumber,
    bool? isNewHouseNumberSelected,
  }) {
    return AddressInfoState(
      familySize: familySize ?? this.familySize,
      city: city ?? this.city,
      subCity: subCity ?? this.subCity,
      status: status ?? this.status,
      specialLocation: specialLocation ?? this.specialLocation,
      houseNumber: isNewHouseNumberSelected == true
          ? const HouseNumber
              .pure() // Reset field if new house number is selected
          : houseNumber ?? this.houseNumber,
      isNewHouseNumberSelected:
          isNewHouseNumberSelected ?? this.isNewHouseNumberSelected,
    );
  }

  @override
  List<Object> get props => [
        houseNumber,
        subCity,
        city,
        familySize,
        status,
        specialLocation,
        isNewHouseNumberSelected
      ];
}
