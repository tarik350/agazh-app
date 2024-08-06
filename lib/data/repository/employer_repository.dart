import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/data/models/Employer.dart';
import 'package:mobile_app/data/models/employee.dart';

class EmployerRepository {
  Employer? _employer;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Employer? getUser() {
    return _employer ?? const Employer();
  }

  void updatePhone(String phone) {
    _employer = (_employer ?? const Employer()).copyWith(phone: phone);
  }

  void updatePersonalInfo(
      {required String fullName,
      required String idCardImagePath,
      required String profilePicturePath,
      required String id}) {
    _employer = (_employer ?? const Employer()).copyWith(
        fullName: fullName,
        idCardImagePath: idCardImagePath,
        profilePicturePath: profilePicturePath,
        id: id);
  }

  void updateAddressInformation({
    required String city,
    required String subCity,
    required String specialLocaion,
    required int houseNumber,
    required int familySize,
  }) {
    _employer = (_employer ?? const Employer()).copyWith(
      city: city,
      subCity: subCity,
      houseNumber: houseNumber,
      specialLocation: specialLocaion,
      familySize: familySize,
    );
  }

  void updatePassword({required String password}) {
    _employer = (_employer ?? const Employer()).copyWith(password: password);
  }

  Future<void> saveEmployer() async {
    try {
      if (_employer == null) {
        throw Exception("Employer can not be null");
      }
      await _firestore
          .collection('employers')
          .doc(_auth.currentUser!.uid)
          .set(_employer!.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<Employer?> getEmployerData() async {
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;
    //
    try {
      // Get the currently authenticated user ID
      String userId = _auth.currentUser!.uid;

      // Fetch the document from Firestore
      DocumentSnapshot docSnapshot =
          await _firestore.collection('employers').doc(userId).get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Convert the document data to an Employer model
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        Employer employer = Employer.fromJson(data);

        return employer;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getRequestsForEmployee() async {
    try {
      // Step 1: Fetch all requests made by the employer
      final employerId = _auth.currentUser!.uid;
      var requestsSnapshot = await _firestore
          .collection('requests')
          .where('employerId', isEqualTo: employerId)
          .get();

      if (requestsSnapshot.docs.isEmpty) {
        // Return null if no requests are found
        return null;
      }

      List<Map<String, dynamic>> requestsData = [];

      // Step 2: For each request, fetch the employee data
      for (var requestDoc in requestsSnapshot.docs) {
        var requestData = requestDoc.data();
        var employeeId = requestData['employeeId'];
        var requestStatus = requestData['status'];
        var requestTimestamp = requestData['timestamp'];

        // Fetch employee data
        var employeeDoc =
            await _firestore.collection('employee').doc(employeeId).get();
        var employeeData = employeeDoc;

        // Construct Employee model if needed
        var employeeModel = Employee.fromDocument(employeeData);

        // Step 3: Combine request data with employee data
        requestsData.add({
          'status': requestStatus,
          'timestamp': requestTimestamp,
          'employee': employeeModel,
        });
      }

      return requestsData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteEmployeeRequest(
      {required String employerId, required String employeeId}) async {
    try {
      // Find the document matching the employerId and employeeId
      var querySnapshot = await _firestore
          .collection('requests')
          .where('employerId', isEqualTo: employerId)
          .where('employeeId', isEqualTo: employeeId)
          .get();

      // If the document exists, delete it
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          await _firestore.collection('requests').doc(doc.id).delete();
        }
      } else {
        throw Exception('Request not found.');
      }
    } catch (e) {
      throw Exception('Failed to delete request: $e');
    }
  }

  Future<void> updateEmployerProfile(
      {required String employerId,
      required Map<String, dynamic> updatedFields}) async {
    try {
      await _firestore
          .collection('employers')
          .doc(employerId)
          .update(updatedFields);
    } catch (e) {
      print('Error updating employer profile: $e');
    }
  }

  Future<void> addRating(
      {required String employeeId,
      required String employerId,
      required String feedback,
      required double rating}) async {
    final firestore = FirebaseFirestore.instance;

    // Add the rating to the ratings collection
    await firestore.collection("employee_ratings").add({
      'employeeId': employeeId,
      'employerId': employerId,
      'rating': rating,
      'feedback': feedback,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update the employee's total rating
    await _updateEmployeeRating(employeeId);
  }

  Future<void> _updateEmployeeRating(String employeeId) async {
    // Get all ratings for the employee
    QuerySnapshot ratingsSnapshot = await _firestore
        .collection("employee_ratings")
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
        .collection("employee_ratings")
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
}
