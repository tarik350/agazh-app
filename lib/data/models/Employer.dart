import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Employer extends Equatable {
  final String fullName;
  final String id;
  final int familySize;
  final String role;
  final String city;
  final String subCity;
  final int houseNumber;
  final String idCardImagePath;
  final String profilePicturePath;
  final String phone;
  final String password;
  final String specialLocation;

  const Employer(
      {this.fullName = '',
      this.id = '',
      this.familySize = 0,
      this.role = 'employer',
      this.city = '',
      this.subCity = '',
      this.houseNumber = 0,
      this.idCardImagePath = '',
      this.profilePicturePath = '',
      this.phone = '',
      this.specialLocation = '',
      this.password = ''});

  factory Employer.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Employer(
      fullName: data['fullName'] ?? '',
      id: data['id'] ?? '',
      familySize: data['familySize'] ?? 0,
      role: data['role'] ?? '',
      city: data['city'] ?? '',
      subCity: data['subCity'] ?? '',
      houseNumber: data['houseNumber'] ?? 0,
      idCardImagePath: data['idCardImagePath'] ?? '',
      profilePicturePath: data['profilePicturePath'] ?? '',
      phone: data['phone'] ?? '',
      specialLocation: data['phone'] ?? '',
      password: data['password'] ?? '',
    );
  }

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      fullName: json['fullName'] ?? '',
      id: json['id'] ?? '',
      familySize: json['familySize'] ?? 0,
      role: json['role'] ?? 'employer',
      city: json['city'] ?? '',
      subCity: json['subCity'] ?? '',
      houseNumber: json['houseNumber'] ?? 0,
      idCardImagePath: json['idCardImagePath'] ?? '',
      profilePicturePath: json['profilePicturePath'] ?? '',
      phone: json['phone'] ?? '',
      specialLocation: json['specialLocation'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'id': id,
      'familySize': familySize,
      'role': role,
      'city': city,
      'subCity': subCity,
      'houseNumber': houseNumber,
      'idCardImagePath': idCardImagePath,
      'profilePicturePath': profilePicturePath,
      'phone': phone,
      'specialLocation': specialLocation,
      'password': password
    };
  }

  Employer copyWith(
      {String? fullName,
      String? id,
      int? familySize,
      String? role,
      String? city,
      String? subCity,
      int? houseNumber,
      String? idCardImagePath,
      String? profilePicturePath,
      String? phone,
      String? specialLocation,
      String? password}) {
    return Employer(
        fullName: fullName ?? this.fullName,
        id: id ?? this.id,
        familySize: familySize ?? this.familySize,
        role: role ?? this.role,
        city: city ?? this.city,
        subCity: subCity ?? this.subCity,
        houseNumber: houseNumber ?? this.houseNumber,
        idCardImagePath: idCardImagePath ?? this.idCardImagePath,
        profilePicturePath: profilePicturePath ?? this.profilePicturePath,
        phone: phone ?? this.phone,
        specialLocation: specialLocation ?? this.specialLocation,
        password: password ?? this.password);
  }

  @override
  List<Object?> get props => [
        fullName,
        id,
        familySize,
        role,
        city,
        subCity,
        houseNumber,
        idCardImagePath,
        profilePicturePath,
        phone,
        specialLocation,
        password
      ];
}
