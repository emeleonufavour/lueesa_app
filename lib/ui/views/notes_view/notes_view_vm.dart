import 'dart:developer';

import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:stacked/stacked.dart';

class NotesViewModel extends BaseViewModel {
  StorageService _storageService = StorageService();
  List<Map<String, String>>? notes;
  String level;
  String courseCode;

  NotesViewModel({required this.level, required this.courseCode});

  getNotes() async {
    notes = await _storageService.getNotesFromStorage(
        level: level, courseCode: courseCode);
    log("Notes from Firebase ==> $notes");
    notifyListeners();
  }
}
