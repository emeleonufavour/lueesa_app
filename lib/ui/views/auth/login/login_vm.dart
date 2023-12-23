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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isOpen = false;
  bool _incorrectEmail = true;
  bool _incorrectPassword = true;

  bool get isOpen => _isOpen;
  bool get incorrectEmail => _incorrectEmail;
  bool get incorrectPassword => _incorrectPassword;
  GlobalKey<FormState> get formKey => _formKey;

  set open(bool value) {
    _isOpen = value;
    notifyListeners();
  }

  set incorrectEmail(bool value) {
    _incorrectEmail = value;
    notifyListeners();
  }

  set incorrectPassword(bool value) {
    _incorrectPassword = value;
    notifyListeners();
  }

  Future<bool> login(BuildContext context) async {
    if (emailController.text.isEmpty || passController.text.isEmpty) {
      IconSnackBar.show(
          context: context,
          label: "Please enter all fields",
          snackBarType: SnackBarType.alert);

      return false;
    }
    if (_formKey.currentState!.validate()) {
      setBusy(true);
      try {
        final result = await runBusyFuture(
            _authService.signInWithEmailAndPassword(
                email: emailController.text, password: passController.text));
        if (context.mounted) {
          if (result) {
            IconSnackBar.show(
                context: context,
                label: 'Login successful!',
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
    }

    return false;
  }
}
