import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
}

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

// Future<Uint8List?> pickImage(ImageSource source) async {
//   final ImagePicker imagePicker = ImagePicker();

//   XFile? file = await imagePicker.pickImage(source: source);

//   if (file != null) {
//     return await file.readAsBytes();
//   } else {
//     return null; // Return null if the user cancels the action
//   }
// }
