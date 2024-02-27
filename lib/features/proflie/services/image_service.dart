import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageService {
  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      return imageFile;
    } else {
      return null;
    }
  }

  Future<String> uploadImageToFirebase({
    required String imagePath,
  }) async {
    String fileName = imagePath.split('/').last;

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Profile images')
        .child(fileName);

    try {
      await ref.putFile(File(imagePath));
    } catch (error) {
      return error.toString();
    }
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }
}
