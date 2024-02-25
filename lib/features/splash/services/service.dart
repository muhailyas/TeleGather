import 'package:firebase_auth/firebase_auth.dart';

class SplashServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
