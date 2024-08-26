import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/role/enums/selected_role.dart';
import 'package:mobile_app/utils/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  Future<void> initAuthStatus() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    _isAuthenticated = preferences.getBool("isAuthenticated") ?? false;
  }

  Future<void> setIsAuthenticated() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isAuthenticated', true);
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isAuthenticated', false);
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<String?> phoneVerification(String phone) async {
    final Completer<String?> completer = Completer<String?>();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          //this call back is code when resend otp is available
        },
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
