import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/data/models/user_old.dart';
import 'package:mobile_app/services/firestore_service.dart';

class AuthService {
  String? verificationId;
  String? name;
  String? phone;
  bool? isAuthenticated;
  UserModel? user;
  final _firestoreService = FirebaseService();

  // AuthService.instance() : isAuthenticated = false;

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
    final user = await FirebaseFirestore.instance
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
}
