part of 'address_info_bloc.dart';

abstract class AddressInfoEvent extends Equatable {
  const AddressInfoEvent();

  @override
  List<Object> get props => [];
}

class HouseNumberChanged extends AddressInfoEvent {
  final String houseNumber;
  const HouseNumberChanged(this.houseNumber);

  @override
  List<Object> get props => [houseNumber];
}

class FamilySizeChanged extends AddressInfoEvent {
  final String familySize;
  const FamilySizeChanged(this.familySize);

  @override
  List<Object> get props => [familySize];
}

class CityChanged extends AddressInfoEvent {
  final String city;
  const CityChanged(this.city);

  @override
  List<Object> get props => [city];
}

class SubCityChanged extends AddressInfoEvent {
  final String country;
  const SubCityChanged(this.country);

  @override
  List<Object> get props => [country];
}

class IdCardChanged extends AddressInfoEvent {
  final String idCardImage;
  const IdCardChanged(this.idCardImage);

  @override
  List<Object> get props => [idCardImage];
}

class SpecialLocaionChanged extends AddressInfoEvent {
  final String specialLocaion;
  const SpecialLocaionChanged(this.specialLocaion);
  @override
  List<Object> get props => [specialLocaion];
}

class FormSubmitted extends AddressInfoEvent {}

class HouseNumberNewSelected extends AddressInfoEvent {
  final bool isNewSelected;

  const HouseNumberNewSelected(this.isNewSelected);
}
