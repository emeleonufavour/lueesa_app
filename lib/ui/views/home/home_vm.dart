import 'dart:developer';

import 'package:lueesa_app/core/services/storage_service.dart';
import 'package:stacked/stacked.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../app/app_setup.locator.dart';

class HomeViewModel extends BaseViewModel {
  final _storageService = locator<StorageService>();
  File? imgFile;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    try {
      // Pick an image from the gallery
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Use the picked file (image)
        File imageFile = File(pickedFile.path);
        imgFile = imageFile;
        notifyListeners();
        // Now, you can work with the imageFile as needed
        // For example, you can display it using an Image widget:
        // Image.file(imageFile);
        log("File => $imageFile");
        // Or you can upload it to a server, process it, etc.
      } else {
        // User canceled the picker
        log("User cancelled");
      }
    } catch (e) {
      // Handle any exceptions that might occur during the image picking process
      log("Error picking image: $e");
    }
  }

  uploadToFirebase() async {
    setBusy(true);
    await pickImage();
    if (imgFile != null) {
      log("uploading from model");
      await _storageService.uploadImage(imgFile!, "Demo", "100", "EIE311");
    } else {
      log("Image file is null");
    }
  }
}
