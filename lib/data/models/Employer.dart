import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Employer extends Equatable {
  final String firstName;
  final String lastName;
  final String id;
  final int familySize;
  final String role;
  final String city;
  final String subCity;
  final String status;
  final dynamic houseNumber;
  final String idCardImagePathFront;
  final String idCardImagePathBack;
  final String profilePicturePath;
  final String phone;
  final String password;
  final String specialLocation;

  const Employer(
      {this.firstName = '',
      this.lastName = '',
      this.id = '',
      this.familySize = 0,
      this.status = 'active',
      this.role = 'employer',
      this.city = '',
      this.subCity = '',
      this.houseNumber = 0,
      this.idCardImagePathFront = '',
      this.idCardImagePathBack = '',
      this.profilePicturePath = '',
      this.phone = '',
      this.specialLocation = '',
      this.password = ''});

  factory Employer.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Employer(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      id: data['id'] ?? '',
      familySize: data['familySize'] ?? 0,
      role: data['role'] ?? '',
      city: data['city'] ?? '',
      subCity: data['subCity'] ?? '',
      status: data['status'] ?? '',
      houseNumber: data['houseNumber'] ?? 0,
      idCardImagePathFront: data['idCardImagePathFront'] ?? '',
      idCardImagePathBack: data['idCardImagePathBack'] ?? '',
      profilePicturePath: data['profilePicturePath'] ?? '',
      phone: data['phone'] ?? '',
      specialLocation: data['phone'] ?? '',
      password: data['password'] ?? '',
    );
  }

  factory Employer.fromJson(Map<String, dynamic> json) {
    return Employer(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      id: json['id'] ?? '',
      familySize: json['familySize'] ?? 0,
      role: json['role'] ?? 'employer',
      city: json['city'] ?? '',
      subCity: json['subCity'] ?? '',
      status: json['status'] ?? "",
      houseNumber: json['houseNumber'] ?? 0,
      idCardImagePathFront: json['idCardImagePathFront'] ?? '',
      idCardImagePathBack: json['idCardImagePathBack'] ?? '',
      profilePicturePath: json['profilePicturePath'] ?? '',
      phone: json['phone'] ?? '',
      specialLocation: json['specialLocation'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'id': id,
      'familySize': familySize,
      'role': role,
      'city': city,
      'lastName': lastName,
      'subCity': subCity,
      'houseNumber': houseNumber,
      'idCardImagePathFront': idCardImagePathFront,
      'idCardImagePathBack': idCardImagePathBack,
      'profilePicturePath': profilePicturePath,
      'phone': phone,
      'specialLocation': specialLocation,
      'password': password,
      'status': status
    };
  }

  Employer copyWith(
      {String? firstName,
      String? lastName,
      String? id,
      int? familySize,
      String? role,
      String? city,
      String? subCity,
      dynamic houseNumber,
      String? idCardImagePathFront,
      String? idCardImagePathBack,
      String? profilePicturePath,
      String? phone,
      String? specialLocation,
      String? password}) {
    return Employer(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        id: id ?? this.id,
        familySize: familySize ?? this.familySize,
        role: role ?? this.role,
        city: city ?? this.city,
        subCity: subCity ?? this.subCity,
        houseNumber: houseNumber ?? this.houseNumber,
        idCardImagePathFront: idCardImagePathFront ?? this.idCardImagePathFront,
        idCardImagePathBack: idCardImagePathBack ?? this.idCardImagePathBack,
        profilePicturePath: profilePicturePath ?? this.profilePicturePath,
        phone: phone ?? this.phone,
        specialLocation: specialLocation ?? this.specialLocation,
        password: password ?? this.password);
  }

  @override
  List<Object?> get props => [
        firstName,
        id,
        familySize,
        role,
        lastName,
        city,
        subCity,
        houseNumber,
        idCardImagePathFront,
        idCardImagePathBack,
        profilePicturePath,
        phone,
        specialLocation,
        password,
        status
      ];
}
