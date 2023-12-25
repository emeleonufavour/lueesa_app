import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';

class PQViewViewModel extends BaseViewModel {
  final _storageService = locator<StorageService>();
  TextEditingController courseCodeCtr = TextEditingController();
  TextEditingController sessionCtr = TextEditingController();
  List<String> downloadUrls = [];
  String? _level;

  String? get level => _level;

  set level(String? value) {
    _level = value;
    notifyListeners();
  }

  Future<void> getPapers(BuildContext context) async {
    setBusy(true);
    try {
      List<String> result = await _storageService.getImagesInDirectory(
          level: level!, courseCode: courseCodeCtr.text, year: sessionCtr.text);
      log("Result => $result");
      downloadUrls = result;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      if (context.mounted) {
        IconSnackBar.show(
            context: context,
            label: "Error fetching images",
            snackBarType: SnackBarType.fail);
      }
    }
    setBusy(false);
  }
}
