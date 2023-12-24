import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.locator.dart';

class PQViewModel extends BaseViewModel {
  final StorageService _storageService = locator<StorageService>();
}
