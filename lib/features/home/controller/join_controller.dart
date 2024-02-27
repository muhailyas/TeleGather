import 'package:flutter/material.dart';
import 'package:video_call_app/features/home/services/home_services.dart';

class JoinWithCodeController extends ChangeNotifier {
  bool isValid = false;
  final HomeServices _services = HomeServices();
  validateJoinCode(String code) async {
    final result = await _services.validateJoinCode(code);
    isValid = result;
    notifyListeners();
  }
}
