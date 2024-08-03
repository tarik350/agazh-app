import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/data/models/employee.dart';
import 'package:mobile_app/screens/employee/widgets/demography/bloc/employee_demography_bloc.dart';
import 'package:mobile_app/utils/exceptions/exceptions.dart';

import '../models/Employer.dart';

class EmployeeRepository {
  Employee? _employee;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Employee? getUser() {
    return _employee ?? const Employee();
  }

  void updateDemographyInformation({
    required String city,
    required String subCity,
    required int houseNumber,
    required JobStatusEnum jobStatus,
  }) {
    _employee = (_employee ?? const Employee()).copyWith(
      city: city,
      subCity: subCity,
      houseNumber: houseNumber,
      jobStatus: jobStatus,
    );
  }

  void updatePersonalInfo(
      {required String fullName,
      required String idCardImagePath,
      required String profilePicturePath,
      required String id}) {
    _employee = (_employee ?? const Employee()).copyWith(
        fullName: fullName,
        idCardImagePath: idCardImagePath,
        profilePicturePath: profilePicturePath,
        id: id);
  }

  void updatePhone(String phone) {
    _employee = (_employee ?? const Employee()).copyWith(phone: phone);
  }

  void updatePassword(String password) {
    _employee = (_employee ?? const Employee()).copyWith(password: password);
  }

  Future<List<Employee>?> fetchEmployeesOrderedByRating() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('employee')
          .orderBy('totalRating', descending: true)
          .get();

      final employees =
          querySnapshot.docs.map((doc) => Employee.fromDocument(doc)).toList();
      return employees;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveEmployee() async {
    try {
      if (_employee == null) {
        throw Exception("Employee can not be null");
      }
      await _firestore
          .collection('employee')
          .doc(_auth.currentUser!.uid)
          .set(_employee!.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<Employee?> getEmployeeByCurrentUserUid() async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        return null;
      }

      final DocumentSnapshot doc =
          await _firestore.collection('employee').doc(user.uid).get();

      if (doc.exists) {
        return Employee.fromDocument(doc);
      } else {
        return null;
      }
    } catch (e) {
      // print('Error getting employee: $e');
      return null;
    }
  }

  Future<List<Employee>?> searchEmployees(String query) async {
    if (query.isEmpty) {
      return null;
    }

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('employees')
          .where('fullName', isGreaterThanOrEqualTo: query)
          .where('fullName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      return snapshot.docs.map((doc) => Employee.fromDocument(doc)).toList();
    } catch (e) {
      print('Error searching employees: $e');
      return null; // Return null in case of an error
    }
  }

  //rating

  Future<void> addRating(
      {required String employeeId,
      required String employerId,
      required double rating}) async {
    final firestore = FirebaseFirestore.instance;

    // Add the rating to the ratings collection
    await firestore.collection('ratings').add({
      'employeeId': employeeId,
      'employerId': employerId,
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update the employee's total rating
    await _updateEmployeeRating(employeeId);
  }

  Future<void> _updateEmployeeRating(String employeeId) async {
    // Get all ratings for the employee
    QuerySnapshot ratingsSnapshot = await _firestore
        .collection('ratings')
        .where('employeeId', isEqualTo: employeeId)
        .get();

    // Calculate the average rating
    double totalRating = 0;
    for (var doc in ratingsSnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      totalRating += data['rating'];
    }

    double averageRating = totalRating / ratingsSnapshot.docs.length;

    // Update the employee's document with the new average rating
    await _firestore.collection('employee').doc(employeeId).update({
      'totalRating': averageRating,
    });
  }

  Future<void> requestEmployee(
      {required String employerId, required String employeeId}) async {
    await FirebaseFirestore.instance.collection('requests').add({
      'employerId': employerId,
      'employeeId': employeeId,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<bool> hasRating(String employeeId, String employerId) async {
    var querySnapshot = await _firestore
        .collection('ratings')
        .where('employeeId', isEqualTo: employeeId)
        .where('employerId', isEqualTo: employerId)
        .get();

    return querySnapshot
        .docs.isNotEmpty; // Returns true if any documents match the query
  }

  Future<bool> hasRequest(
      {required String employerId, required String employeeId}) async {
    var querySnapshot = await _firestore
        .collection('requests')
        .where('employerId', isEqualTo: employerId)
        .where('employeeId', isEqualTo: employeeId)
        .where('status',
            isEqualTo: 'pending') // Optional: Only check for pending requests
        .get();

    return querySnapshot
        .docs.isNotEmpty; // Returns true if any documents match the query
  }

  Future<void> updateEmployeeProfile(
      {required String employeeId,
      required Map<String, dynamic> updatedFields}) async {
    try {
      await _firestore
          .collection('employee')
          .doc(employeeId)
          .update(updatedFields);
    } catch (e) {
      print('Error updating employer profile: $e');
    }
  }
}
