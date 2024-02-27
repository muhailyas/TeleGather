import 'package:flutter/material.dart';
import 'package:video_call_app/features/authentication/controller/authentication_controller.dart';
import 'package:video_call_app/features/authentication/view/login.dart';
import 'package:video_call_app/features/home/view/home.dart';

// authentication utils
showResult(String value, BuildContext context) {
  switch (value) {
    case 'navigate-to-home':
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ScreenHome()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login success'), backgroundColor: Colors.teal));
      break;
    case 'navigate-to-login':
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ScreenLogin()));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Account has been created'),
          backgroundColor: Colors.teal));
      break;
    default:
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value), backgroundColor: Colors.red));
  }
}

void clearForm(AuthenticationController controller, value) {
  if ('navigate-to-home' == value || value == 'navigate-to-login') {
    controller.emailController.clear();
    controller.passwordController.clear();
    controller.confirmPasswordController.clear();
  }
}
