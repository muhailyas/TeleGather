class UserModel {
  String? id;
  String email;
  String userName;
  String? userProfile;

  UserModel({
    this.id,
    required this.email,
    required this.userName,
    this.userProfile,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      userName: json['username'],
      userProfile: json['profile'],
    );
  }

  toJson() {
    return {
      'id': id,
      'email': email,
      'username': userName,
      'profile': userProfile,
    };
  }
}
