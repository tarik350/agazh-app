import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/data/models/employee.dart';
import 'package:mobile_app/screens/employee/widgets/demography/bloc/employee_demography_bloc.dart';

import '../models/Employer.dart';

class EmployeeRepository {
  Employee? _employee;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Employee? getUser() {
    return _employee ?? const Employee();
  }

  void updateDemographyInformation(
      {required String city,
      required String subCity,
      required dynamic houseNumber,
      required JobStatusEnum jobStatus,
      required int salaray}) {
    _employee = (_employee ?? const Employee()).copyWith(
      city: city,
      salary: salaray,
      subCity: subCity,
      houseNumber: houseNumber,
      jobStatus: jobStatus,
    );
  }

  void updateOtherDetails(
      {required int age, required String religion, required String workType}) {
    _employee = (_employee ?? const Employee())
        .copyWith(age: age, religion: religion, workType: workType);
  }

  void updatePersonalInfo(
      {required String firstName,
      required String lastName,
      required String idCardImagePathBack,
      required String idCardImagePathFront,
      required String profilePicturePath,
      required String id}) {
    _employee = (_employee ?? const Employee()).copyWith(
        firstName: firstName,
        lastName: lastName,
        idCardImagePathBack: idCardImagePathBack,
        idCardImagePathFront: idCardImagePathFront,
        profilePicturePath: profilePicturePath,
        id: id);
  }

  void updatePhone(String phone) {
    _employee = (_employee ?? const Employee()).copyWith(phone: phone);
  }

  void updatePassword(String password) {
    _employee = (_employee ?? const Employee()).copyWith(password: password);
  }

  Future<List<Employee>?> fetchEmployeesOrderedByRating(
      {String? workTypeFilter, String? name}) async {
    try {
      // Start with a CollectionReference
      CollectionReference collection = _firestore.collection('employee');

      // Initialize the query from the collection reference
      Query query = collection;

      if (name != null && name.isNotEmpty) {
        query = query
            .orderBy('firstName')
            .orderBy('totalRating', descending: true)
            .where('firstName', isGreaterThanOrEqualTo: name)
            .where('firstName', isLessThanOrEqualTo: '$name\uf8ff');
      } else {
        query = query.orderBy('totalRating', descending: true);
      }

      if (workTypeFilter != null && workTypeFilter.isNotEmpty) {
        query = query.where('workType', isEqualTo: workTypeFilter);
      }

      QuerySnapshot querySnapshot = await query.get();

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
          .where('firstNamee', isGreaterThanOrEqualTo: query)
          .where('firstNamee', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      return snapshot.docs.map((doc) => Employee.fromDocument(doc)).toList();
    } catch (e) {
      print('Error searching employees: $e');
      return null; // Return null in case of an error
    }
  }

  //rating

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

  Future<List<Map<String, dynamic>>?> getEmployeeRequests() async {
    try {
      String employeeId = _auth.currentUser?.uid ?? '';

      if (employeeId.isEmpty) {
        throw Exception('No user is currently logged in.');
      }

      QuerySnapshot requestSnapshot = await _firestore
          .collection('requests')
          .where('employeeId', isEqualTo: employeeId)
          .get();

      if (requestSnapshot.docs.isEmpty) {
        return null;
      }

      List<Map<String, dynamic>> result = [];

      for (var doc in requestSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        String employerId = data['employerId'];

        DocumentSnapshot employerSnapshot =
            await _firestore.collection('employers').doc(employerId).get();

        if (employerSnapshot.exists) {
          var employerData = employerSnapshot.data() as Map<String, dynamic>;
          Employer employer = Employer.fromJson(employerData);

          result.add({
            'status': data['status'],
            'employer': employer,
            'timestamp': data['timestamp'],
          });
        }
      }

      return result.isEmpty ? null : result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getEmployeeRatingsWithEmployers() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return null;
      }

      final uid = user.uid;

      // Query employee_ratingss where employeeId is the current user's UID
      final ratingsQuerySnapshot = await _firestore
          .collection('employee_ratings')
          .where('employeeId', isEqualTo: uid)
          .get();

      if (ratingsQuerySnapshot.docs.isEmpty) {
        return null; // No ratings found
      }

      List<Map<String, dynamic>> ratingsWithEmployers = [];

      for (var ratingDoc in ratingsQuerySnapshot.docs) {
        final ratingData = ratingDoc.data();
        final employerId = ratingData['employerId'];

        // Fetch the associated employer from the employers collection
        final employerDoc =
            await _firestore.collection('employers').doc(employerId).get();

        if (employerDoc.exists) {
          final empoyer = Employer.fromDocument(employerDoc);
          ratingsWithEmployers.add({
            'employer': empoyer,
            'rating': ratingData['rating'],
            'feedback': ratingData['feedback'],
          });
        }
      }

      return ratingsWithEmployers;
    } catch (e) {
      print('Error fetching employee ratings with employers: $e');
      return null;
    }
  }

  Future<void> updateEmployeePassword(String newPassword) async {
    try {
      final userId = _auth.currentUser?.uid;

      if (userId == null) {
        throw Exception("User is not logged in");
      }

      final employeeDocRef = _firestore.collection('employee').doc(userId);

      await employeeDocRef.update({'password': newPassword});
    } catch (e) {
      throw Exception("Failed to update password: $e");
    }
  }
}
