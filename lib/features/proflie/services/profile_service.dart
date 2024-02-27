import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_call_app/features/authentication/model/user_model.dart';

class ProfileServices {
  final _fireStore = FirebaseFirestore.instance;

  Future<String> createUserProfile({required UserModel user}) async {
    try {
      await _fireStore.collection('Users').doc(user.id).set(user.toJson());
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  updateUserProfilePicture(
      {required String image, required String userId}) async {
    await _fireStore.collection('Users').doc(userId).update({'profile': image});
  }

  updateUserName({required String userName, required String userId}) async {
    await _fireStore
        .collection('Users')
        .doc(userId)
        .update({'username': userName});
  }

  Future<UserModel?> getUserInfo() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDocumentSnapshot =
        await _fireStore.collection('Users').doc(userId).get();
    if (userDocumentSnapshot.exists) {
      return UserModel.fromJson(
          userDocumentSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }
}
