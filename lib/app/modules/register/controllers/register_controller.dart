import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class RegisterController extends GetxController {
  final usernameC = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final RxBool isPassword = true.obs;
  var selectedImage = Rxn<XFile>();
  var apiConstant = ApiConstant();
  final box = Hive.box('user');
  final ImagePicker _picker = ImagePicker();

  void showPassword() {
    if (isPassword.value == true) {
      isPassword.value = false;
      print('Password is visible');
    } else {
      isPassword.value = true;
      print('Password is hidden');
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      selectedImage.value = pickedFile;
    }
  }

  void register() async {
    print('Sedang daftar');

    if (passwordController.text == cpasswordController.text) {
      final file = selectedImage.value;
      dio.FormData formData = dio.FormData.fromMap({
        if (file != null)
          'profile_picture': await dio.MultipartFile.fromFile(
            file.path,
            filename: file.name,
          ),
        'name': nameController.text,
        'username': usernameC.text,
        'password': passwordController.text,
        'email': emailController.text,
      });

      postUser(formData);
    } else {
      Get.snackbar(
        'Gagal',
        'Password tidak sama',
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> postUser(FormData formData) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '${apiConstant.BASE_URL}/register',
        options: Options(method: 'POST'),
        data: formData,
      );

      if (response.statusCode == 201) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
      print('Berhasil mendaftar');
      Get.snackbar(
        'Berhasil',
        'Akun berhasil dibuat',
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      print('Gagal mendaftar: $e');
      Get.snackbar(
        'Gagal',
        'Akun gagal dibuat',
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
