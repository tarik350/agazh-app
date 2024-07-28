part of 'address_info_bloc.dart';

class AddressInfoState extends Equatable {
  const AddressInfoState({
    this.houseNumber = const HouseNumber.pure(),
    // this.familySize = const FamilySize.pure(),
    this.city = const City.pure(),
    // this.country = const Country.pure(),
    this.idCardIage = const IdCardImage.pure(),
    this.status = FormzStatus.pure,
  });

  final HouseNumber houseNumber;
  // final FamilySize familySize;
  final City city;
  // final Country country;
  final IdCardImage idCardIage;
  final FormzStatus status;

  AddressInfoState copyWith({
    HouseNumber? houseNumber,
    // FamilySize? familySize,
    City? city,
    // Country? country,
    IdCardImage? idCardIage,
    FormzStatus? status,
  }) {
    return AddressInfoState(
      houseNumber: houseNumber ?? this.houseNumber,
      // familySize: familySize ?? this.familySize,
      city: city ?? this.city,
      // country: country ?? this.country,
      idCardIage: idCardIage ?? this.idCardIage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [houseNumber, city, idCardIage, status];
}
