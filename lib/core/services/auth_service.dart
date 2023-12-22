import 'dart:developer';

import 'package:lueesa_app/core/models/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential _userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      log("User logged in: ${_userCred.user?.email}");
    } catch (e) {
      log("Error while siging in ==> $e");
    }
  }
}
