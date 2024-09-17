import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final uuid = const Uuid();

  Future<String> uploadImgeToStorage(String childName, file,
      {String? fileName}) async {
    Reference ref;
    final String fileRef = uuid.v4();

    ref = _storage.ref().child(childName).child(fileName ?? fileRef);

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
