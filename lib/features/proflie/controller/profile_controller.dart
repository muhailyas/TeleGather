import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_call_app/features/authentication/model/user_model.dart';
import 'package:video_call_app/features/proflie/services/image_service.dart';
import 'package:video_call_app/features/proflie/services/profile_service.dart';

class ProfileController extends ChangeNotifier {
  String username = '';
  String email = '';
  String profileImage = '';
  bool loading = false;
  final _profileServices = ProfileServices();
  final _imageServices = ImageService();

  Future<String> createProfile() async {
    final currentInfo = FirebaseAuth.instance.currentUser;
    final user = UserModel(
      email: currentInfo!.email ?? '',
      userName: currentInfo.displayName ?? '',
      id: currentInfo.uid,
      userProfile: '',
    );
    final image = await _profileServices.createUserProfile(user: user);
    return image;
  }

  Future<String> updateProfile(
      {required String imagePath, required String userId}) async {
    final networkImage =
        await _imageServices.uploadImageToFirebase(imagePath: imagePath);
    _profileServices.updateUserProfilePicture(
        image: networkImage, userId: userId);
    return networkImage;
  }

  updateUserName({required String username}) async {
    loading = true;
    notifyListeners();
    await _profileServices.updateUserName(
        userName: username, userId: FirebaseAuth.instance.currentUser!.uid);
    loading = false;
    notifyListeners();
    getUserProfile();
  }

  getUserProfile() async {
    final userInfo = await _profileServices.getUserInfo();
    if (userInfo == null) {
      return;
    }
    username = userInfo.userName;
    email = userInfo.email;
    profileImage = userInfo.userProfile!;
    notifyListeners();
  }

  updateImageLocal() async {
    final imageFile = await ImageService().pickImage();
    if (imageFile != null) {
      profileImage = imageFile.path;
      notifyListeners();
      updateProfile(
          imagePath: imageFile.path,
          userId: FirebaseAuth.instance.currentUser!.uid);
      notifyListeners();
    }
  }
}
