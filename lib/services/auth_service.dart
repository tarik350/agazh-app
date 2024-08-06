import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/data/models/Employer.dart';
import 'package:mobile_app/data/models/user_old.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:mobile_app/utils/exceptions/exceptions.dart';

import '../data/models/employee.dart';

class AuthService {
  String? verificationId;
  String? name;
  String? phone;
  bool? isAuthenticated;
  UserModel? user;
  final _firestoreService = FirebaseService();

  void setIsAuthenticated(bool isAuth) {
    isAuthenticated = isAuth;
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> phoneVerification(String phone) async {
    final Completer<String?> completer = Completer<String?>();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(verificationId);
        },
      );
    } catch (e) {
      completer.completeError(e);
      rethrow;
    }
    return completer.future;
  }

  // this.verificationId = verificationId;
  // this.phone = phone;
  // context.router.push(OTPRoute(mode: mode));
  Future<void> registerWithPhone(
      {required String name,
      required String phone,
      required BuildContext context}) async {
    this.name = name;
    this.phone = phone;
    final users = FirebaseFirestore.instance.collection('users');
    try {
      final docRef =
          await users.where('phoneNumber', isEqualTo: phone).count().get();
      final exists = docRef.count! > 0;

      if (!exists) {
        if (context.mounted) {
          phoneVerification(phone);
        }
      } else {
        //todo show error user with this phone alraedy exists
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> verifyOtpRegister(String otp) async {
    final credintials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId!, smsCode: otp));
    //todo logic to register user with firebase
    if (credintials.user != null) {
      final user = UserModel(name: name!, phoneNumber: phone!, role: "");
      await _firestoreService.createUser(
          user: user, uuid: credintials.user!.uid);
      this.user = user;
      return true;
    } else {
      return false;
    }

    // return credintials.user != null ? true : false;
  }

  Future<bool> verifyOtp(String otp, String verificationId) async {
    try {
      final credintials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));

      return credintials.user != null ? true : false;
    } catch (e) {
      //todo show error => error while verifying OTP
      return false;
    }
  }

  Future<String?> getUserRole() async {
    final user = await _db
        .collection('users')
        .where('phoneNumber', isEqualTo: phone)
        .get();

    final userDetail = user.docs.first.data();
    if (userDetail.isEmpty) {
      return null;
    } else {
      return userDetail['role'];
    }
  }

  void updateUser({
    String? name,
    String? password,
    String? phoneNumber,
    String? role,
    String? language,
    String? location,
  }) {
    if (name != null) user!.name = name;
    // if (password != null) user.password = password;
    if (phoneNumber != null) {
      user!.phoneNumber = phoneNumber;
    }
    if (role != null) user!.role = role;
    if (language != null) {
      user!.language = language;
    }
    if (location != null) {
      user!.location = location;
    }
  }

  Future<bool> checkUserExists(String phoneNumber, UserRole role) async {
    try {
      if (role.name == 'none') {
        throw RoleCanNotBeNoneException();
      }
      final String collectionName =
          role == UserRole.employee ? "employee" : "employers";

      CollectionReference employerCollection =
          FirebaseFirestore.instance.collection(collectionName);

      QuerySnapshot querySnapshot =
          await employerCollection.where('phone', isEqualTo: phoneNumber).get();

      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> lookupUser(
      String phone, String password, String collectionName) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final QuerySnapshot querySnapshot = await firestore
          .collection(collectionName)
          .where('phone', isEqualTo: phone)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
