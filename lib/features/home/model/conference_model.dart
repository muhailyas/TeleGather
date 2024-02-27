class ConferenceModel {
  String conferenceId;
  String userId;
  ConferenceModel({required this.conferenceId, required this.userId});
  factory ConferenceModel.fromJson(Map<String, dynamic> json) {
    return ConferenceModel(conferenceId: json['ids'], userId: json['userId']);
  }
}
