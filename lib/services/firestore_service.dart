import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/init_service.dart';
import 'package:mobile_app/data/models/user_old.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createUser(
      {required UserModel user, required String uuid}) async {
    final users = _db.collection('users');
    try {
      await users.doc(getit<AuthService>().phone).set(user.toMap());
    } catch (e) {
      //todo show error => error while adding the user
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _db.collection('users').doc(user.phoneNumber).update(user.toMap());
    } catch (e) {
      //todo -> error -> error while updating the user information
    }
  }
}
