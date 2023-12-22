import 'dart:developer';

import 'package:lueesa_app/core/models/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lueesa_app/core/services/user_service.dart';

import '../../app/app_setup.locator.dart';

class AuthService implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userService = locator<UserService>();
  @override
  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      log("User logged in: ${userCred.user?.email}");
      _userService.isLoggedIn = true;
      return true;
    } catch (e) {
      log("Error while siging in ==> $e");
    }
    return false;
  }
}
