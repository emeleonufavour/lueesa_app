import 'package:flutter/material.dart';
import 'package:lueesa_app/app/app_setup.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';
import '../../../core/services/user_service.dart';

class SplashScreenViewModel extends BaseViewModel {
  late AnimationController controller;
  final _navService = locator<NavigationService>();
  final _userService = locator<UserService>();

  goToLogin() {
    _userService.isLoggedIn
        ? _navService.navigateToHomeView()
        : _navService.navigateToLoginView();
  }
}
