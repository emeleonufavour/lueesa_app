import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app_setup.locator.dart';

class AddCourseViewModel extends BaseViewModel {
  final _storageService = locator<StorageService>();
  TextEditingController codeCtr = TextEditingController();
  TextEditingController titleCtr = TextEditingController();
  TextEditingController timeCtr = TextEditingController();
  TextEditingController lectCtr = TextEditingController();
  final FocusNode codeFocusNode = FocusNode();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode timeFocusNode = FocusNode();
  final FocusNode lectFocusNode = FocusNode();

  Timer? _typingTimer;
  bool _isTyping = false;

  bool _tapped = false;
  String? _level;
  String? _day;

  bool get tapped => _tapped;
  String? get level => _level;
  String? get day => _day;
  bool get isTyping => _isTyping;
  Timer? get typingTime => _typingTimer;

  set tapped(bool value) {
    _tapped = value;
    notifyListeners();
  }

  set level(String? value) {
    _level = value;
    notifyListeners();
  }

  set day(String? value) {
    _day = value;
    notifyListeners();
  }

  set isTyping(bool value) {
    _isTyping = value;
    notifyListeners();
  }

  onTextChanged() {
    // Cancel the previous timer
    _typingTimer?.cancel();

    // Start a new timer
    _typingTimer = Timer(const Duration(seconds: 2), () {
      // This code will be executed when the user stops typing
      isTyping = false;
      notifyListeners();
      log('User has stopped typing and isTyping => $isTyping');
    });
  }

  addCourseToDay(BuildContext context) async {
    if (level != null &&
        day != null &&
        codeCtr.text.isNotEmpty &&
        titleCtr.text.isNotEmpty &&
        lectCtr.text.isNotEmpty &&
        timeCtr.text.isNotEmpty) {
      setBusy(true);
      bool result = await _storageService.addCourseToDay(
          level: level!,
          day: day!,
          code: codeCtr.text,
          title: titleCtr.text,
          lect: lectCtr.text,
          time: timeCtr.text);

      if (context.mounted) {
        if (result) {
          IconSnackBar.show(
              context: context,
              label: "Course was added successfully",
              snackBarType: SnackBarType.save);
          Navigator.of(context).pop();
        } else {
          IconSnackBar.show(
              context: context,
              label: "There was an error while adding course",
              snackBarType: SnackBarType.save);
        }
      }
    } else {
      IconSnackBar.show(
          context: context,
          label: "No field must be empty",
          snackBarType: SnackBarType.fail);
      throw Exception("No field must be empty");
    }
    setBusy(false);
  }
}
