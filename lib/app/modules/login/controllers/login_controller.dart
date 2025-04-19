import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:kelola_barang/app/shared/models/user_model.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isPassword = true.obs;

  Dio dio = Dio();
  var apiConstant = ApiConstant();
  final box = Hive.box('user');

  void showPassword() {
    if (isPassword.value == true) {
      isPassword.value = false;
      debugPrint('Password is visible');
    } else {
      isPassword.value = true;
      debugPrint('Password is hidden');
    }
  }

  void logout() {
    usernameController.clear();
    passwordController.clear();
    box.clear();
    Get.snackbar(
      'logout-success'.tr,
      'confirm-logout-success'.tr,
      duration: const Duration(seconds: 2),
      colorText: ColorStyle.white,
      backgroundColor: ColorStyle.primary,
    );
    Get.offAllNamed('/onboarding');
  }

  Future<UserModel?> login(String username, String password) async {
    if (password.length < 6) {
      Get.snackbar(
        'Login Gagal',
        'Password minimal 6 karakter',
        duration: const Duration(seconds: 2),
        colorText: ColorStyle.white,
        backgroundColor: Colors.red,
      );
      return null;
    }

    var dio = Dio();
    var response = await dio.request(
      '${apiConstant.BASE_URL}/login',
      options: Options(method: 'POST'),
      data: {'username': username, 'password': password},
    );

    if (response.statusCode == 200 && response.data != null) {
      print(json.encode(response.data));

      await box.put('token', response.data['token']);
      await box.put('user', response.data['user']);

      Get.snackbar(
        'Login Berhasil',
        'Selamat datang ${response.data['user']['name']}',
        duration: const Duration(seconds: 2),
        colorText: ColorStyle.white,
        backgroundColor: ColorStyle.primary,
      );
      Get.offAllNamed('/home');
    } else {
      print('Login failed');
      print(response.statusCode);
      print(response.data);
      print(response.statusMessage);
    }
    return null;
  }
}
