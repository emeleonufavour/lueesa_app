import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  set open(bool value) {
    _isOpen = value;
    notifyListeners();
  }
}
