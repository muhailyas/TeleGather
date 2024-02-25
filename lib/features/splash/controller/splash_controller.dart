import 'package:flutter/material.dart';
import 'package:video_call_app/features/splash/services/service.dart';

class SplashController extends ChangeNotifier {
  final SplashServices _services = SplashServices();
  Future<String> checkUserExistenceAndNavigate() async {
    final user = _services.getCurrentUser();
    if (user != null) {
      return 'navigate-to-home';
    } else {
      return 'navigate-to-login';
    }
  }
}
