import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:lueesa_app/app/app_setup.router.dart';
import 'package:lueesa_app/core/enums/greeting.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:stacked/stacked.dart';
import 'dart:io';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';

class HomeViewModel extends BaseViewModel {
  final _storageService = locator<StorageService>();
  late ScrollController scrollController;
  bool _showInfo = false;
  final hour = DateTime.now().hour;
  bool _isBoxTapped = false;
  Greeting? greeting;
  final _navService = locator<NavigationService>();
  File? imgFile;
  List<Map<String, String>> carouselImages = [];

  bool get showInfo => _showInfo;
  bool get isBoxTapped => _isBoxTapped;

  set showInfo(bool value) {
    _showInfo = value;
    notifyListeners();
  }

  set isBoxTapped(bool value) {
    _isBoxTapped = value;
    notifyListeners();
  }

  Future<void> getCarouselImages(BuildContext context) async {
    setBusy(true);
    try {
      List<Map<String, String>> result =
          await _storageService.getCarouselImages();
      log("Result => $result");
      carouselImages = result;
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

  knowGreeting() {
    if (hour < 12) {
      greeting = Greeting.morning;
      notifyListeners();
    } else if (hour < 17) {
      greeting = Greeting.afteroon;
      notifyListeners();
    } else {
      greeting = Greeting.evening;
      notifyListeners();
    }
    notifyListeners();
  }

  bool get isSliverAppBarExpanded {
    return scrollController.hasClients &&
        (scrollController.offset > (200 - kToolbarHeight));
  }

  goToPastQuestionsUpload() {
    _navService.navigateToPastQuestionUploadScreen();
  }

  goToPastQuestionsView() {
    _navService.navigateToPQViewScreen();
  }

  goToTimeTable() => _navService.navigateToTimeTableView();

  goToUploadNotes() => _navService.navigateToNotesUploadScreen();

  goToExecutives() => _navService.navigateToExecsView();

  goToVoting() => _navService.navigateToVotingLoginScreen();
}
