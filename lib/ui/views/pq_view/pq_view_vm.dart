import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';

class PQViewViewModel extends BaseViewModel with ListenableServiceMixin {
  final _storageService = locator<StorageService>();
  TextEditingController courseCodeCtr = TextEditingController();
  TextEditingController sessionCtr = TextEditingController();
  final status = Permission.manageExternalStorage.status;
  List<Map<String, String>> contents = [];
  String? _level;
  bool _isDownloading = false;
  //String _progress = "0";
  final ReactiveValue<double> _progress = ReactiveValue<double>(0.0);
  StreamController<double> _streamController = StreamController<double>();
  bool _isDownloaded = false;

  String? get level => _level;
  bool get isDownloading => _isDownloading;
  double get progress => _progress.value;
  bool get isDownloaded => _isDownloaded;

  set level(String? value) {
    _level = value;
    notifyListeners();
  }

  set progress(double value) {
    _progress.value = value;
    notifyListeners();
  }

  set isDownloaded(bool value) {
    _isDownloaded = value;
    notifyListeners();
  }

  set isDownloading(bool value) {
    _isDownloading = value;
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

  download(
      {required String downloadUrl,
      required String fileName,
      required BuildContext context}) async {
    log("Starting download...");
    isDownloading = true;
    String savePath = await getFilePath(fileName);
    log("File path ==> $savePath");

    Dio dio = Dio();

    dio.download(downloadUrl, savePath, onReceiveProgress: (rcv, total) {
      log('received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}');

      _progress.value = double.parse(((rcv / total) * 100).toStringAsFixed(0));

      if (_progress.value == 100) {
        isDownloaded = true;
        isDownloading = false;
        notifyListeners();
        log("isDownloading ==> $isDownloading");

        log("Download complete!");
      } else if (_progress.value < 100) {
        log("Progress ==> ${progress / 100}");
      }
    }, deleteOnError: true).then((value) async {
      if (_progress.value == 100) {
        isDownloaded = true;
        isDownloading = false;
        log("isDownloading ==> $isDownloading");
        final result = await ImageGallerySaver.saveFile(savePath);
        log("Result from saving to gallery => ${result["isSuccess"]}");
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: result["isSuccess"]
                  ? "Successfully downloaded"
                  : "Error saving to gallery",
              snackBarType:
                  result["isSuccess"] ? SnackBarType.save : SnackBarType.fail);
        }

        log("Download complete!");
      }
    });
  }

  saveToGallery(
      {required String downloadUrl,
      required String fileName,
      required BuildContext context}) async {
    if (await status.isGranted) {
      log("Permission is granted");
      if (context.mounted) {
        await download(
            downloadUrl: downloadUrl, fileName: fileName, context: context);
      }
    } else {
      PermissionStatus newStatus =
          await Permission.manageExternalStorage.request();
      if (newStatus.isGranted) {
        log('Storage permission granted.');
        if (context.mounted) {
          await download(
              downloadUrl: downloadUrl, fileName: fileName, context: context);
        }
      } else {
        log('Storage permission denied.');
        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Permission denied",
              snackBarType: SnackBarType.fail);
        }
      }
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName.png';

    return path;
  }
}
//File path ==> /data/user/0/com.example.lueesa_app/app_flutter/demo.png