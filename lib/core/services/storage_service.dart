import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lueesa_app/core/models/info_box.dart';
import 'package:lueesa_app/core/models/time_table.dart';

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

        log("Timetable ==> $timetables");
        return timetables;
      } else {
        return [];
      }
    } catch (e) {
      log("Error getting timetable data: $e");
      return [];
    }
  }

  Future<bool> addCourseToDay(
      {required String level,
      required String day,
      required String code,
      required String title,
      required String lect,
      required String time}) async {
    CollectionReference collection = _firestore.collection('timetables');
    DocumentReference documentReference = collection.doc(level);
    String fieldToUpdate = 'days';

    try {
      // Get the timetable for particular level from firestore
      DocumentSnapshot docSnapshot = await documentReference.get();

      if (docSnapshot.exists) {
        // Store the timetable in a new variable
        List<Map<String, dynamic>> timetables = List<Map<String, dynamic>>.from(
            (docSnapshot.data() as Map<String, dynamic>)[fieldToUpdate]);

        log("Old timetable ==> $timetables");

        // update the properties of the local variable
        Course course =
            Course(code: code, title: title, time: time, lect: lect);
        switch (day.toLowerCase()) {
          case "monday":
            List courses = timetables[0]['courses'];
            if (!courses.contains(course.toJson())) {
              courses.add(course.toJson());
            }

            break;
          case "tuesday":
            List courses = timetables[1]['courses'];
            if (!courses.contains(course.toJson())) {
              courses.add(course.toJson());
            }
            break;
          case "wednesday":
            List courses = timetables[2]['courses'];
            if (!courses.contains(course.toJson())) {
              courses.add(course.toJson());
            }
            break;
          case "thursday":
            List courses = timetables[3]['courses'];
            if (!courses.contains(course.toJson())) {
              courses.add(course.toJson());
            }
            break;
          case "friday":
            List courses = timetables[4]['courses'];
            if (!courses.contains(course.toJson())) {
              courses.add(course.toJson());
            }
            break;
          default:
            log("Day isn't well formatted");

          // upload the local variable as a new field
        }
        log("Updating timetable");
        await documentReference.update({
          fieldToUpdate: timetables,
        });
        log("New Timetable ==> $timetables");
      }
      log('Course added to the "courses" array successfully!');
      return true;
    } catch (e) {
      log('Error adding course to the "courses" array: $e');
    }
    return false;
  }

  //CRUD operations on Info Box.....
  String boardCollection = "info_board";

  //Create
  Future<void> addInfo(InfoBox note) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
    DateTime time = DateTime.now();
    String timeStamp =
        "${time.month}.${time.day}.${time.hour}.${time.minute}.${time.second}";
    await FirebaseFirestore.instance
        .collection(boardCollection)
        .doc(timeStamp)
        .set({
      'userId': userId,
      'from': note.from,
      'to': note.to,
      'data': note.message,
      'time': timeStamp,
    });
  }

  //Update
  Future<void> updateInfo(String noteId, String newText) async {
    log("Updating box with id ==> $noteId");
    await FirebaseFirestore.instance
        .collection(boardCollection)
        .doc(noteId)
        .update({'data': newText});
  }

  //Delete
  deleteInfo(String noteId) async {
    await FirebaseFirestore.instance
        .collection(boardCollection)
        .doc(noteId)
        .delete();
  }

  //CRUD Operations on PDF Notes
  Future<void> uploadFileToStorage({
    required String filePath,
    required String level,
    required String courseCode,
    required String year,
  }) async {
    if (filePath.isNotEmpty) {
      try {
        String fileName = filePath.split('/').last;

        String storagePath =
            "notes/$level/${courseCode.trim().toLowerCase()}/$year/${fileName.toLowerCase()}";

        await _storage.ref(storagePath).putFile(File(filePath));

        // Get the download URL of the uploaded file
        String downloadURL = await _storage.ref(storagePath).getDownloadURL();

        log('File uploaded to: $downloadURL');
      } catch (e) {
        log('Error uploading file: $e');
      }
    }
  }
}
