import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';
import '../../../core/services/storage_service.dart';

class NotesViewModel extends BaseViewModel {
  final StorageService _storageService = locator<StorageService>();
  TextEditingController imgNameCtr = TextEditingController();
  final FocusNode sessionFocusNode = FocusNode();
  String? _filePath;
  String? _level;
  TextEditingController courseCodeCtr = TextEditingController();
  TextEditingController sessionCtr = TextEditingController();
  Timer? _typingTimer;
  bool _tapped = false;
  bool _resize = false;

  String? get level => _level;
  bool get tapped => _tapped;
  bool get resize => _resize;
  Timer? get typingTime => _typingTimer;
  String? get fileName => _filePath?.split('/').last;

  set tapped(bool value) {
    _tapped = value;
    notifyListeners();
  }

  set level(String? value) {
    _level = value;

    notifyListeners();
  }

  set resize(bool value) {
    _resize = value;
    notifyListeners();
  }

  onTextChanged() {
    // Cancel the previous timer
    _typingTimer?.cancel();

    // Start a new timer
    _typingTimer = Timer(const Duration(seconds: 3), () {
      // This code will be executed when the user stops typing
      resize = false;
      notifyListeners();
      log('User has stopped typing: ${sessionCtr.text} and resize => $resize');
    });
  }

  Future<void> pickFile(BuildContext context) async {
    log("Trying to pick file");
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        log("Result from picking file ==> $result");
        File file = File(result.files.single.path!);
        _filePath = result.files.single.path!;
        notifyListeners();
      } else {
        // User canceled the picker
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Unable to pick file",
              snackBarType: SnackBarType.fail);
        }
      }
    } catch (e) {
      log("Error picking file ==> $e");
    }
  }

  uploadFile(BuildContext context) async {
    if (_filePath != null &&
        level != null &&
        courseCodeCtr.text.isNotEmpty &&
        sessionCtr.text.isNotEmpty) {
      setBusy(true);
      try {
        await _storageService.uploadFileToStorage(
            filePath: _filePath!,
            level: level!,
            courseCode: courseCodeCtr.text,
            year: sessionCtr.text);
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Successfully uploaded",
              snackBarType: SnackBarType.save);
        }
      } catch (e) {
        log("Error uploading PDF to Firebase ::: $e");
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Unable to upload file",
              snackBarType: SnackBarType.fail);
        }
      }
      setBusy(false);
    } else {
      IconSnackBar.show(
          context: context,
          label: "No field should be empty :(",
          snackBarType: SnackBarType.fail);
    }
  }
}
