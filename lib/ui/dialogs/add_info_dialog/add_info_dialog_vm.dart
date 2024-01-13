import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:lueesa_app/core/models/info_box.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/storage_service.dart';

class AddInfoViewModel extends BaseViewModel {
  StorageService _storageService = StorageService();
  TextEditingController fromCtr = TextEditingController();
  TextEditingController toCtr = TextEditingController();
  TextEditingController msgCtr = TextEditingController();
  InfoBox? box;
  bool get cameWithContent => box != null ? true : false;

  AddInfoViewModel({this.box}) {
    if (box != null) {
      log('Adding info for existing box');
      fromCtr.text = box!.from;
      toCtr.text = box!.to;
      msgCtr.text = box!.message;

      notifyListeners();
    }
  }

  Future<bool> addNoteToStorage(BuildContext context) async {
    DateTime time = DateTime.now();
    String timeStamp =
        "${time.year}/${time.month}/${time.day}/${time.hour}/${time.minute}/${time.second}";
    if (fromCtr.text.isNotEmpty &&
        toCtr.text.isNotEmpty &&
        msgCtr.text.isNotEmpty) {
      try {
        await _storageService.addInfo(InfoBox(
            from: fromCtr.text,
            to: toCtr.text,
            message: msgCtr.text,
            time: timeStamp));
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Successfully added",
              snackBarType: SnackBarType.save);
        }

        return true;
      } catch (e) {
        if (context.mounted) {
          log("Error uploading ::: ${e.toString()}");
          IconSnackBar.show(
              context: context,
              label: "Could not add note",
              snackBarType: SnackBarType.fail);
        }
        return false;
      }
    } else {
      IconSnackBar.show(
          context: context,
          label: "Input all fields!",
          snackBarType: SnackBarType.fail);
      return false;
    }
  }

  Future<bool> updateNote(BuildContext context) async {
    if (box != null) {
      try {
        await _storageService.updateInfo(box!.time, msgCtr.text);

        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Successfully updated",
              snackBarType: SnackBarType.save);
          return true;
        }
      } catch (e) {
        log(e.toString());
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Could not update",
              snackBarType: SnackBarType.fail);
        }
        return false;
      }
    }
    return false;
  }
}
