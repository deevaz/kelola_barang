import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/other/edit_profile/repositories/edit_profile_repository.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';
import 'package:path_provider/path_provider.dart';

import '../models/edit_user_model.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rxn<XFile>();

  final _repo = EditProfileRepo();
  final userId = BaseController.to.userId.value;
  final token = BaseController.to.token.value;

  @override
  void onInit() {
    super.onInit();
    setInitialData();
    print("User ID: $userId");
  }

  void setInitialData() {
    final userBox = Hive.box<UserResponseModel>('user');
    final user = userBox.get('user');

    if (user != null) {
      print("Data user ditemukan");
      nameController.text = user.name;
      usernameController.text = user.username;
      emailController.text = user.email;
      print("Name: ${user.name}");
      if (user.profilePicture.isNotEmpty) {
        prepareDownloadedImage(user.profilePicture);
      }
    }
  }

  Future<void> updateUser() async {
    final user = EditUserModel(
      name: nameController.text,
      username: usernameController.text,
      email: emailController.text,

      files: selectedImage.value != null ? [selectedImage.value!] : [],
    );

    await _repo.updateUser(user);

    BaseController.to.getUserData();
  }

  Future<void> pickImage(isCamera) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFile != null) {
      final fileSize = await pickedFile.length();
      if (fileSize > 2 * 1024 * 1024) {
        SnackbarService.error('File too large', 'Max size is 2MB');
        return;
      }
      selectedImage.value = pickedFile;
    }
  }

  Future<void> prepareDownloadedImage(String imageUrl) async {
    final dir = await getTemporaryDirectory();
    final filename = imageUrl.split('/').last;
    final filePath = '${dir.path}/$filename';

    final response = await Dio().download(imageUrl, filePath);
    if (response.statusCode == 200) {
      selectedImage.value = XFile(filePath);
      print('Gambar berhasil diunduh: $filePath');
    } else {
      print('Gagal download gambar');
    }
  }
}
