import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class UserModel {
  List<XFile> files;
  String name;
  String username;
  String email;
  String? password;

  UserModel({
    required this.files,
    required this.name,
    required this.username,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  Future<FormData> toFormData() async {
    final multipartFiles = await Future.wait(
      files.map(
        (file) => MultipartFile.fromFile(file.path, filename: file.name),
      ),
    );

    return FormData.fromMap({
      'profile_picture':
          multipartFiles.isNotEmpty ? multipartFiles.first : null,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });
  }

  static UserModel fromXFiles({
    required List<XFile> files,
    required String name,
    required String username,
    required String email,
    required String password,
  }) {
    return UserModel(
      files: files,
      name: name,
      username: username,
      email: email,
      password: password,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      files: [],
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: (json['password'] as String),
    );
  }

  Future<FormData> toFormDataForUpdate() async {
    final multipartFiles = await Future.wait(
      files.map(
        (file) => MultipartFile.fromFile(file.path, filename: file.name),
      ),
    );

    return FormData.fromMap({
      'files': multipartFiles,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      '_method': 'PUT',
    });
  }
}
