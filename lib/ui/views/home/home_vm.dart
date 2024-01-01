import 'dart:developer';

import 'package:lueesa_app/app/app_setup.router.dart';
import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:stacked/stacked.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_setup.locator.dart';

class HomeViewModel extends BaseViewModel {
  final _storageService = locator<StorageService>();
  final _navService = locator<NavigationService>();
  File? imgFile;

  goToPastQuestionsUpload() {
    _navService.navigateToPastQuestionUploadScreen();
  }

  goToPastQuestionsView() {
    _navService.navigateToPQViewScreen();
  }

  goToTimeTable() => _navService.navigateToTimeTableView();
}
