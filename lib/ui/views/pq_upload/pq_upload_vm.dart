import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';

class PQViewModel extends BaseViewModel {
  final StorageService _storageService = locator<StorageService>();
  TextEditingController imgNameCtr = TextEditingController();
  File? imgFile;
  String? _level;
  TextEditingController courseCodeCtr = TextEditingController();
  TextEditingController sessionCtr = TextEditingController();
  bool _tapped = false;

  String? get level => _level;
  bool get tapped => _tapped;

  set tapped(bool value) {
    _tapped = value;
    notifyListeners();
  }

  set level(String? value) {
    _level = value;

    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        imgFile = imageFile;

        notifyListeners();

        log("File path => ${imageFile.path}");
        // Or you can upload it to a server, process it, etc.
      } else {
        // User canceled the picker
        log("User cancelled");
      }
    } catch (e) {
      // Handle any exceptions that might occur during the image picking process
      log("Error picking image: $e");
    }
  }

  uploadImage(BuildContext context) async {
    if (level == null) {
      IconSnackBar.show(
          context: context,
          label: "Add the course level",
          snackBarType: SnackBarType.alert);
    } else {
      setBusy(true);

      if (imgFile != null) {
        log("uploading from model");
        try {
          await _storageService.uploadImage(
              imgFile: imgFile!,
              imgName: imgNameCtr.text,
              level: level!,
              courseCode: courseCodeCtr.text,
              year: sessionCtr.text);
          if (context.mounted) {
            IconSnackBar.show(
                context: context,
                label: "Upload successful!",
                snackBarType: SnackBarType.save);
          }
        } catch (e) {
          if (context.mounted) {
            IconSnackBar.show(
                context: context,
                label: "Unable to upload image ",
                snackBarType: SnackBarType.save);
          }
        }
      } else {
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Error picking image",
              snackBarType: SnackBarType.fail);
        }
      }
      setBusy(false);
    }
  }
}
