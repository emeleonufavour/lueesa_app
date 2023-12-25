import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String?> uploadImage(
      {required File imgFile,
      required String imgName,
      required String level,
      required String courseCode,
      required String year}) async {
    String storagePath =
        "past_questions/$level/${courseCode.toLowerCase()}/$year/${imgName.toLowerCase()}";
    try {
      log("uploading from service");
      Reference storageReference = _storage.ref().child(storagePath);
      UploadTask uploadTask = storageReference.putFile(imgFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<List<String>> getImagesInDirectory(
      {required String level,
      required String courseCode,
      required String year}) async {
    String directoryPath =
        "past_questions/$level/${courseCode.toLowerCase()}/$year/";
    try {
      ListResult listResult =
          await FirebaseStorage.instance.ref().child(directoryPath).list();
      List<String> downloadUrls = [];

      for (Reference item in listResult.items) {
        String downloadUrl = await item.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }

      return downloadUrls;
    } catch (e) {
      log('Error fetching images: $e');
      return [];
    }
  }
}
