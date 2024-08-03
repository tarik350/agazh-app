part of 'address_info_bloc.dart';

class AddressInfoState extends Equatable {
  const AddressInfoState({
    this.houseNumber = const HouseNumber.pure(),
    this.city = const City.pure(),
    this.familySize = const FamilySize.pure(),
    this.subCity = const SubCity.pure(),
    this.status = FormzStatus.pure,
  });

  final HouseNumber houseNumber;
  final FamilySize familySize;
  final City city;
  final FormzStatus status;
  final SubCity subCity;

  AddressInfoState copyWith({
    HouseNumber? houseNumber,
    FamilySize? familySize,
    City? city,
    SubCity? subCity,
    FormzStatus? status,
  }) {
    return AddressInfoState(
      houseNumber: houseNumber ?? this.houseNumber,
      familySize: familySize ?? this.familySize,
      city: city ?? this.city,
      subCity: subCity ?? this.subCity,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [houseNumber, subCity, city, familySize, status];
}
