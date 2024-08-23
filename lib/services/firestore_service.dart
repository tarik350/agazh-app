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

  Future<String> uploadImgeToStorage(String childName, file,
      {String? fileName}) async {
    Reference ref;

    ref = _storage
        .ref()
        .child(childName)
        .child(fileName ?? _auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
