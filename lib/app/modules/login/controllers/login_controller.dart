import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';

import 'package:kelola_barang/app/shared/services/auth_services.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isPassword = true.obs;
  final AuthServices _authService = AuthServices();

  Dio dio = Dio();
  var apiConstant = ApiConstant();
  final Box<UserResponseModel> userBox = Hive.box<UserResponseModel>('user');
  final Box<String> authBox = Hive.box<String>('auth');

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
    userBox.clear();
    authBox.clear();
    Get.snackbar(
      'logout-success'.tr,
      'confirm-logout-success'.tr,
      duration: const Duration(seconds: 2),
      colorText: ColorStyle.white,
      backgroundColor: ColorStyle.primary,
    );
    Get.offAllNamed('/onboarding');
  }

  Future<void> login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text;

    await _authService.login(username, password);
  }
}
