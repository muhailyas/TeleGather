import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends ChangeNotifier {
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();
    return statuses[Permission.camera] == PermissionStatus.granted &&
        statuses[Permission.microphone] == PermissionStatus.granted;
  }

  Future<bool> checkPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus microphoneStatus = await Permission.microphone.status;

    return cameraStatus.isGranted && microphoneStatus.isGranted;
  }
}
