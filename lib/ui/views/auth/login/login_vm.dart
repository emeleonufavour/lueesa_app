import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:lueesa_app/app/routing/screen_path.dart';
import 'package:stacked/stacked.dart';

import '../../../../app/app_setup.locator.dart';
import '../../../../core/services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  set open(bool value) {
    _isOpen = value;
    notifyListeners();
  }

  Future<bool> login(BuildContext context) async {
    try {
      setBusy(true);
      final result = await runBusyFuture(
          _authService.signInWithEmailAndPassword(
              email: "emele", password: "passController.text"));
      if (context.mounted) {
        if (result) {
          IconSnackBar.show(
              context: context,
              label: "Login successful!",
              snackBarType: SnackBarType.save);
          context.go(ScreenPath.home);
        } else {
          IconSnackBar.show(
              context: context,
              label: 'Error during sign in',
              snackBarType: SnackBarType.fail);
        }
      }

      return true;
    } catch (e) {
      log('error message: ${e.toString()}');
    }

    setBusy(false);
    return false;
  }
}
