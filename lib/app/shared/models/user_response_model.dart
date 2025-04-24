import 'package:hive/hive.dart';

part 'user_response_model.g.dart';

@HiveType(typeId: 0)
class UserResponseModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String username;

  @HiveField(4)
  final String profilePicture;

  UserResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.profilePicture,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      profilePicture: json['profile_picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'profile_picture': profilePicture,
    };
  }
}
