import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_app/screens/employee/widgets/demography/bloc/employee_demography_bloc.dart';
import 'package:mobile_app/screens/role/enums/work_status.dart';

class Employee extends Equatable {
  final String firstName;
  final String lastName;

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
  final int salary;

  const Employee(
      {this.firstName = '',
      this.lastName = '',
      this.id = '',
      this.salary = 0,
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
        firstName,
        lastName,
        id,
        salary,
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
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        id: json['id'] ?? '',
        salary: json['salary'] ?? 0,
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
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
      "salary": salary,
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
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        id: doc.id,
        salary: data['salary'] ?? 0,
        profilePicturePath: data['profilePicturePath'] ?? '',
        idCardImagePath: data['idCardImagePath'] ?? '',
        city: data['city'] ?? '',
        subCity: data['subCity'] ?? '',
        houseNumber: data['houseNumber'] ?? 0,
        totalRating: data['totalRating'] ?? 0.0,
        password: data['password'] ?? '',
        phone: data['phone'] ?? '',
        jobStatus: data['jobstatus'] == "fullTime"
            ? JobStatusEnum.fullTime
            : JobStatusEnum.partTime,
        role: data['role'] ?? 'employee',
        age: getAge(data['age']),
        religion: data['religion'] ?? '',
        workType: data['workType'] ?? '');
  }

  static int getAge(dynamic age) {
    if (age == null) {
      return 0;
    }
    switch (age.runtimeType) {
      case String:
        return int.parse(age);
      case int:
        return age;
      default:
        return 0;
    }
  }

  Employee copyWith(
      {String? firstName,
      String? lastName,
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
      int? salary,
      String? religion,
      String? workType}) {
    return Employee(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
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
      workType: workType ?? this.workType,
      salary: salary ?? this.salary,
    );
  }
}
