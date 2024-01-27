import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';

class ExecsViewModel extends BaseViewModel {
  final _storage = locator<StorageService>();
  List<Map<String, String>> execs_list = [];

  Future<void> getExecsList(BuildContext context) async {
    log("Getting execs....");
    setBusy(true);
    try {
      List<Map<String, String>> result = await _storage.getExecsImages();
      execs_list = result;
      log("Result ==> $result");
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        IconSnackBar.show(
            context: context,
            label: "Error while getting images",
            snackBarType: SnackBarType.fail);
      }
    }
    setBusy(false);
  }
}
