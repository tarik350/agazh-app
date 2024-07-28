import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/UserAuthDetail.dart';

class Employeer extends Equatable {
  const Employeer(
      {required this.personalInfo,
      required this.addressInfo,
      required this.userAuthDetail});

  final PersonalInfo personalInfo;
  final AddressInfo addressInfo;
  final UserAuthDetail userAuthDetail;

  factory Employeer.empty() {
    return Employeer(
        personalInfo: PersonalInfo.empty(),
        addressInfo: AddressInfo.empty(),
        userAuthDetail: UserAuthDetail.empty());
  }

  Employeer copyWith(
      {PersonalInfo? personalInfo,
      AddressInfo? addressInfo,
      UserAuthDetail? userAuthDetail}) {
    return Employeer(
        personalInfo: personalInfo ?? this.personalInfo,
        addressInfo: addressInfo ?? this.addressInfo,
        userAuthDetail: userAuthDetail ?? this.userAuthDetail);
  }

  Map<String, dynamic> toJson() {
    return {
      'personalInfo': personalInfo.toJson(),
      "addressInfo": addressInfo.toJson()
    };
  }

  factory Employeer.fromJson(Map<String, dynamic> json) {
    return Employeer(
        personalInfo: json['personalInfo'],
        addressInfo: json['addressInfo'],
        userAuthDetail: json['userAuthDetail']);
  }

  @override
  List<Object?> get props => [personalInfo, addressInfo];
}

class PersonalInfo extends Equatable {
  const PersonalInfo({
    required this.fullName,
    required this.idCardPathString,
  });

  final String fullName;
  final String idCardPathString;

  factory PersonalInfo.empty() {
    return const PersonalInfo(
      fullName: '',
      idCardPathString: '',
    );
  }

  PersonalInfo copyWith({
    String? fullName,
    String? idCardPathString,
  }) {
    return PersonalInfo(
      fullName: fullName ?? this.fullName,
      idCardPathString: idCardPathString ?? this.idCardPathString,
    );
  }

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      fullName: json['fullName'],
      idCardPathString: json['idCardPathString'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'idCardPathString': idCardPathString,
    };
  }

  @override
  List<Object?> get props => [fullName, idCardPathString];
}

class AddressInfo extends Equatable {
  const AddressInfo({
    required this.houseNumber,
    // required this.familySize,
    required this.city,
    required this.idCardImage,
  });

  final String houseNumber;
  // final String familySize;
  final String city;

  final String idCardImage;

  factory AddressInfo.empty() {
    return const AddressInfo(
      houseNumber: '',
      // familySize: '',
      city: '',
      idCardImage: '',
    );
  }

  AddressInfo copyWith({
    String? houseNumber,
    String? familySize,
    String? city,
    String? idCardImage,
  }) {
    return AddressInfo(
      houseNumber: houseNumber ?? this.houseNumber,
      // familySize: familySize ?? this.familySize,
      city: city ?? this.city,
      idCardImage: idCardImage ?? this.idCardImage,
    );
  }

  factory AddressInfo.fromJson(Map<String, dynamic> json) {
    return AddressInfo(
      houseNumber: json['houseNumber'],
      // familySize: json['familySize'],
      city: json['city'],
      idCardImage: json['idCardImage'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'houseNumber': houseNumber,
      // 'familySize': familySize,
      'city': city,
      'idCardImage': idCardImage
    };
  }

  @override
  List<Object?> get props => [houseNumber, city, idCardImage];
}

class Payment extends Equatable {
  const Payment({
    required this.cardName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvvNumber,
  });

  final String cardName;
  final String cardNumber;
  final String expiryDate;
  final String cvvNumber;

  factory Payment.empty() {
    return const Payment(
      cardName: '',
      cardNumber: '',
      expiryDate: '',
      cvvNumber: '',
    );
  }

  Payment copyWith({
    String? cardName,
    String? cardNumber,
    String? expiryDate,
    String? cvvNumber,
  }) {
    return Payment(
      cardName: cardName ?? this.cardName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvvNumber: cvvNumber ?? this.cvvNumber,
    );
  }

  @override
  List<Object?> get props => [cardName, cardNumber, expiryDate, cvvNumber];
}
