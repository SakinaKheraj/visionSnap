import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
      required super.id,
      required super.email,
      super.username,
      super.fullname,
      super.avatarUrl,
  });

   // Convert JSON from API to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
      return UserModel(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        fullname: json['fullname'],
        avatarUrl: json['avatarUrl'],
      );
  }

  // Convert UserModel to JSON for API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'fullname': fullname,
      'avatarUrl': avatarUrl,
    };
  }
  
}