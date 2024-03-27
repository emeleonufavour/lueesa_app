import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:lueesa_app/app/app_setup.router.dart';
import 'package:lueesa_app/core/services/voting_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app_setup.locator.dart';

class VoteLoginViewModel extends BaseViewModel {
  VotingService _votingService = VotingService();
  final _navService = locator<NavigationService>();

  Future<bool> signInWithMail(BuildContext context) async {
    try {
      User? user = await _votingService.signInWithGoogle();
      if (user != null) {
        log("User --> $user");

        if (context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Successful",
              snackBarType: SnackBarType.save);
        }
        _navService.navigateToVotingScreen(user: user);
        return true;
      }
    } catch (e) {
      log("Error signing in with Google --> $e");
      if (context.mounted) {
        IconSnackBar.show(
            context: context,
            label: "Error while Signing in :(",
            snackBarType: SnackBarType.fail);
      }
    }
    return false;
  }
}
