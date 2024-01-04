import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String?> uploadImage(
      {required File imgFile,
      required String imgName,
      required String level,
      required String courseCode,
      required String year}) async {
    String storagePath =
        "past_questions/$level/${courseCode.trim().toLowerCase()}/$year/${imgName.toLowerCase()}";
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

  Future<List<Map<String, String>>> getImagesInDirectory(
      {required String level,
      required String courseCode,
      required String year}) async {
    String directoryPath =
        "past_questions/$level/${courseCode.trim().toLowerCase()}/$year/";
    try {
      ListResult listResult =
          await FirebaseStorage.instance.ref().child(directoryPath).list();
      List<Map<String, String>> contents = [];

      for (Reference item in listResult.items) {
        String downloadUrl = await item.getDownloadURL();
        String name = item.name;
        log("Name => ${item.name}");
        contents.add({"name": name, "downloadUrl": downloadUrl});
        // downloadUrls.add(downloadUrl);
      }

      return contents;
    } catch (e) {
      log('Error fetching images: $e');
      return [];
    }
  }

  getTimetable(String level) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('timetables').doc(level).get();

      if (snapshot.exists) {
        List<Map<String, dynamic>> timetables = List<Map<String, dynamic>>.from(
            (snapshot.data() as Map<String, dynamic>)['days']);
        return timetables;
      } else {
        return [];
      }
    } catch (e) {
      log("Error getting timetable data: $e");
      return [];
    }
  }

  addCourseToDay(
    String level,
  ) async {
    CollectionReference collection = _firestore.collection('timetables');
    DocumentReference documentReference = collection.doc("100");

    try {
      // Update the document by adding a new course to the "courses" array
      await documentReference.update({
        "days": FieldValue.arrayUnion([
          {
            "courses": [
              {
                "code": "EIE 311",
                "lect": "Engr. Dickson",
                "time": "8:00-10:00am",
                "title": "Electronics"
              }
            ],
            "day": "Tuesday",
          }
        ]),
      });
      log('Course added to the "courses" array successfully!');
    } catch (e) {
      log('Error adding course to the "courses" array: $e');
    }
  }
}
