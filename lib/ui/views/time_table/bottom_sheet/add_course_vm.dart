import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
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

  // addCourseToDay() async => await _storageService.addCourseToDay("");
}
