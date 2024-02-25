import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_call_app/features/authentication/model/login_model.dart';
import 'package:video_call_app/features/authentication/model/sign_up_model.dart';
import 'package:video_call_app/features/authentication/model/user_model.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<String, UserModel>> signWithEmailAndPassword(
      {required LoginModel loginModel}) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
              email: loginModel.email, password: loginModel.password);
      final success = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          userName: userCredential.user!.displayName ?? '');
      return right(success);
    } catch (e) {
      String errorMessage = 'An error occurred while signing in';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage =
                'User not found. Please check your email and try again.';
            break;
          case 'wrong-password':
            errorMessage = 'Invalid password. Please try again.';
            break;
          case 'invalid-email':
            errorMessage = 'Invalid email address. Please enter a valid email.';
            break;
          default:
            errorMessage = 'An error occurred. Please try again later.';
            break;
        }
      }
      return left(errorMessage);
    }
  }

  Future<Either<String, UserModel>> signUpWithEmailAndPassword(
      {required SignUpModel signUpModel}) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: signUpModel.email, password: signUpModel.password);
      final success = UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email!,
          userName: userCredential.user!.displayName ?? '');
      return right(success);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred while signing in';
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              'Email already existing. Please check your email and try again.';
          break;
        case 'weak-password':
          errorMessage = 'Weak password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address. Please enter a valid email.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
          break;
      }
      return left(errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<String> logOut() async {
    try {
      await _auth.signOut();
      return 'navigate-to-login';
    } catch (e) {
      String errorMessage = 'An error occurred while logging out';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'sign-out-failed':
            errorMessage = 'Sign out failed. Please try again.';
            break;
          default:
            errorMessage =
                'An unexpected error occurred. Please try again later.';
            break;
        }
      }
      return errorMessage;
    }
  }
}
