import 'dart:developer';
//import 'dart:html';
import 'dart:io';

//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';

class PQViewViewModel extends BaseViewModel {
  final _storageService = locator<StorageService>();
  TextEditingController courseCodeCtr = TextEditingController();
  TextEditingController sessionCtr = TextEditingController();
  //final status = Permission.storage.status;
  List<Map<String, String>> contents = [];
  String? _level;
  bool _isDownloading = false;
  String _progress = "0";
  bool _isDownloaded = false;

  String? get level => _level;
  bool get isDownloading => _isDownloading;
  String get progress => _progress;
  bool get isDownloaded => _isDownloaded;

  set level(String? value) {
    _level = value;
    notifyListeners();
  }

  set progress(String value) {
    _progress = value;
    notifyListeners();
  }

  set isDownloaded(bool value) {
    _isDownloaded = value;
    notifyListeners();
  }

  set isDownloading(bool value) {
    _isDownloading = true;
    notifyListeners();
  }

  Future<void> getPapers(BuildContext context) async {
    setBusy(true);
    try {
      List<Map<String, String>> result =
          await _storageService.getImagesInDirectory(
              level: level!,
              courseCode: courseCodeCtr.text,
              year: sessionCtr.text);
      log("Result => $result");
      contents = result;
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

  download({required String downloadUrl, required String fileName}) async {
    // log("Starting download...");
    // isDownloading = true;
    // String savePath = await getFilePath(fileName);
    // log("File path ==> $savePath");

    // Dio dio = Dio();

    // dio.download(downloadUrl, savePath, onReceiveProgress: (rcv, total) {
    //   log('received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');

    //   progress = ((rcv / total) * 100).toStringAsFixed(0);

    //   if (progress == "100") {
    //     isDownloaded = true;
    //     log("Download complete!");
    //   } else if (double.parse(progress) < 100) {
    //     log("Progress ==> $progress");
    //   }
    // }, deleteOnError: true).then((value) {
    //   if (progress == "100") {
    //     isDownloaded = true;
    //     log("Download complete!");
    //   }
    //   isDownloading = false;
    // });
  }

  saveToGallery() async {
    // if (await status.isGranted) {
    //   log("Permission is granted");
    // } else {
    //   PermissionStatus newStatus = await Permission.storage.request();
    //   if (newStatus.isGranted) {
    //     log('Storage permission granted.');
    //   } else {
    //     log('Storage permission denied.');
    //   }
    // }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName.png';

    return path;
  }
}
//File path ==> /data/user/0/com.example.lueesa_app/app_flutter/demo.png