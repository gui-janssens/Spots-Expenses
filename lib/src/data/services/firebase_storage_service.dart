import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<TaskSnapshot> uploadFile(
      File? file, Uint8List? webImage, String uuid) async {
    if (file != null) {
      return await FirebaseStorage.instance.ref('items/$uuid').putFile(file);
    }
    if (webImage != null) {
      return await FirebaseStorage.instance
          .ref('items/$uuid')
          .putData(webImage);
    }

    throw 'Image method not implemented';
  }

  static Future<void> deleteFile(String ref) async {
    await FirebaseStorage.instance.ref(ref).delete();
  }
}
