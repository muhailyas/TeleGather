import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_call_app/features/authentication/model/login_model.dart';
import 'package:video_call_app/features/authentication/model/sign_up_model.dart';
import 'package:video_call_app/features/authentication/services/services.dart';

class AuthenticationController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final FirebaseAuthServices _authServices = FirebaseAuthServices();
  String showMessage = '';
  bool loading = false;
  Future<String> signWithEmailAndPassword(
      {required LoginModel loginModel, required BuildContext context}) async {
    loading = true;
    notifyListeners();
    final response =
        await _authServices.signWithEmailAndPassword(loginModel: loginModel);
    response.fold((l) {
      showMessage = l;
    }, (r) {
      showMessage = 'navigate-to-home';
    });
    loading = false;
    notifyListeners();
    return showMessage;
  }

  Future<String> signUpWithEmailAndPassword(
      {required SignUpModel signUpModel, required BuildContext context}) async {
    loading = true;
    notifyListeners();
    if (signUpModel.confirmPassword != signUpModel.password) {
      loading = false;
      notifyListeners();
      return 'Passwords do not match';
    }
    final response = await _authServices.signUpWithEmailAndPassword(
        signUpModel: signUpModel);
    response.fold((l) {
      showMessage = l;
    }, (r) {
      showMessage = 'navigate-to-login';
    });
    loading = false;
    notifyListeners();
    return showMessage;
  }

  Future<String> logOut() async {
    final response = await _authServices.logOut();
    return response;
  }
}
