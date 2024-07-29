import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_app/services/auth_service.dart';
import 'package:mobile_app/services/init_service.dart';
import 'package:mobile_app/data/models/user_old.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<String> uploadImgeToStorage(String childName, file) async {
    Reference ref;
    //we are creating a path here where we are going to store the image
    //the reason we are using  a Uint8List instead of File is to allow both the mobile
    //and web apps work in one same code base

    // String id = const Uuid().v1();
//this referance allows to store diffrent posts of the same user without over writting one with another
// _auth.currentUser!.uid
    ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    // } else {
    //   ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    // }

    // the reason we are using putData instead of putFile is b/c the file type is Uint8List
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    // we are using this url to display the uploaded image by taking it's url
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
