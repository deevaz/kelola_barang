import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class EditUserModel {
  List<XFile> files;
  String name;
  String username;
  String email;

  EditUserModel({
    required this.files,
    required this.name,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'username': username, 'email': email};
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
    });
  }

  static EditUserModel fromXFiles({
    required List<XFile> files,
    required String name,
    required String username,
    required String email,
    required String password,
  }) {
    return EditUserModel(
      files: files,
      name: name,
      username: username,
      email: email,
    );
  }

  factory EditUserModel.fromJson(Map<String, dynamic> json) {
    return EditUserModel(
      files: [],
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
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
      '_method': 'PUT',
    });
  }
}
