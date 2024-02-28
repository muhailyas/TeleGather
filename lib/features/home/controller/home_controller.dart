import 'package:flutter/material.dart';
import 'package:video_call_app/features/home/model/conference_model.dart';
import 'package:video_call_app/features/home/model/video_conference_model.dart';
import 'package:video_call_app/features/home/services/home_services.dart';

class HomeController extends ChangeNotifier {
  bool isdelete = false;
  final TextEditingController codeController = TextEditingController();
  VideoConferenceModel? videoConferenceInfo;
  String instantId = '';
  bool deleteLoading = false;
  List<ConferenceModel> conferences = [];
  final HomeServices _homeServices = HomeServices();
  deleteToggle() {
    isdelete = !isdelete;
    notifyListeners();
  }

  Future<String> startQuickConference() async {
    final response = await _homeServices.startQuickConference();
    final result = response.fold((l) {
      videoConferenceInfo = l;
      notifyListeners();
      return 'navigate-to-conference';
    }, (r) => r);
    return result;
  }

  Future<String> copyToClipBoard(String text) async {
    return await _homeServices.copyToClipBoard(text);
  }

  getConferences() async {
    final response = await _homeServices.getConferences();
    conferences = response.map((e) => ConferenceModel.fromJson(e)).toList();
    notifyListeners();
  }

  Future<String> getConferenceLinkToLink() async {
    final id = await _homeServices.getConferenceLinkToLink();
    instantId = id;
    notifyListeners();
    getConferences();
    return id;
  }

  deleteConference(String conferenceId) async {
    deleteLoading = true;
    notifyListeners();
    await _homeServices.deleteConfereferenceId(conferenceId);
    isdelete = false;
    notifyListeners();
    deleteLoading = false;
    notifyListeners();
    getConferences();
  }
}
