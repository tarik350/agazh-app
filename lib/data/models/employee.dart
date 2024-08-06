import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/screens/employee/widgets/demography/bloc/employee_demography_bloc.dart';
import 'package:mobile_app/screens/role/enums/work_status.dart';

class Employee extends Equatable {
  final String fullName;
  final String id;
  final String profilePicturePath;
  final String idCardImagePath;
  final String city;
  final String subCity;
  final int houseNumber;
  // final WorkStatus workStatus;
  final String password;
  final String role;
  final JobStatusEnum jobStatus;
  final String phone;
  final num totalRating;
  final String workType;
  final int age;
  final String religion;

  const Employee(
      {this.fullName = '',
      this.id = '',
      this.totalRating = 0.0,
      this.jobStatus = JobStatusEnum.none,
      this.profilePicturePath = '',
      this.idCardImagePath = '',
      this.city = '',
      this.subCity = '',
      this.houseNumber = 0,
      this.phone = '',
      // this.workStatus = WorkStatus.fullTime,
      this.password = '',
      this.role = 'employee',
      //new properties
      this.age = 0,
      this.religion = '',
      this.workType = ''});

  @override
  List<Object?> get props => [
        fullName,
        id,
        profilePicturePath,
        idCardImagePath,
        city,
        subCity,
        houseNumber,
        totalRating,
        password,
        role,
        phone,
        jobStatus,
        age,
        religion,
        workType
      ];

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        fullName: json['fullName'] ?? '',
        id: json['id'] ?? '',
        profilePicturePath: json['profilePicturePath'] ?? '',
        idCardImagePath: json['idCardImagePath'] ?? '',
        city: json['city'] ?? '',
        subCity: json['subCity'] ?? '',
        houseNumber: json['houseNumber'] ?? 0,
        jobStatus: json['jobStatus'] ?? '',
        totalRating: json['totalRating'] ?? 0.0,
        password: json['password'] ?? '',
        role: json['role'] ?? 'employee',
        phone: json['phone'] ?? '',
        workType: json['workType'] ?? "",
        age: json['age'] ?? 0,
        religion: json['religion'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'id': id,
      'profilePicturePath': profilePicturePath,
      'idCardImagePath': idCardImagePath,
      'city': city,
      'subCity': subCity,
      'houseNumber': houseNumber,
      // 'workStatus': workStatus.name,
      'password': password,
      'jobstatus': jobStatus.name,
      'role': role,
      'phone': phone,
      'totalRating': totalRating,
      'age': age,
      'religion': religion,
      'workType': workType
    };
  }

  factory Employee.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Employee(
        fullName: data['fullName'] ?? '',
        id: doc.id,
        profilePicturePath: data['profilePicturePath'] ?? '',
        idCardImagePath: data['idCardImagePath'] ?? '',
        city: data['city'] ?? '',
        subCity: data['subCity'] ?? '',
        houseNumber: data['houseNumber'] ?? 0,
        // workStatus:
        //     WorkStatusExtension.fromString(data['workStatus'] ?? 'fullTime'),
        totalRating: data['totalRating'] ?? 0.0,
        password: data['password'] ?? '',
        phone: data['phone'] ?? '',
        jobStatus: data['jobstatus'] == "fullTime"
            ? JobStatusEnum.fullTime
            : JobStatusEnum.partTime,
        role: data['role'] ?? 'employee',
        age: data['age'] != null ? int.parse(data['age']) : 0,
        religion: data['religion'] ?? '',
        workType: data['workType'] ?? '');
  }

  Employee copyWith(
      {String? fullName,
      String? id,
      String? profilePicturePath,
      String? idCardImagePath,
      String? city,
      String? subCity,
      int? houseNumber,
      WorkStatus? workStatus,
      String? phone,
      String? password,
      double? totalRating,
      String? role,
      JobStatusEnum? jobStatus,
      int? age,
      String? religion,
      String? workType}) {
    return Employee(
        fullName: fullName ?? this.fullName,
        id: id ?? this.id,
        profilePicturePath: profilePicturePath ?? this.profilePicturePath,
        idCardImagePath: idCardImagePath ?? this.idCardImagePath,
        city: city ?? this.city,
        subCity: subCity ?? this.subCity,
        houseNumber: houseNumber ?? this.houseNumber,
        totalRating: totalRating ?? this.totalRating,
        password: password ?? this.password,
        role: role ?? this.role,
        phone: phone ?? this.phone,
        jobStatus: jobStatus ?? this.jobStatus,
        age: age ?? this.age,
        religion: religion ?? this.religion,
        workType: workType ?? this.workType);
  }
}
