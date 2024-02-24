import 'package:flutter/material.dart';
import 'package:video_call_app/features/proflie/services/image_service.dart';

class ImageController extends ChangeNotifier {
  String profileImage = '';
  updateImage() async {
    final imageFile = await ImageService().pickImage();
    if (imageFile != null) {
      profileImage = imageFile.path;
      notifyListeners();
    }
  }
}
