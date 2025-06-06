import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/other/forgot_password/models/reset_password_model.dart';
import 'package:kelola_barang/app/modules/other/forgot_password/repositories/reset_password_repository.dart';

class ForgotPasswordController extends GetxController {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  final tokenC = TextEditingController();
  final RxBool isPassword = true.obs;
  final ResetPasswordRepository _repo = ResetPasswordRepository();

  void showPassword() {
    if (isPassword.value == true) {
      isPassword.value = false;
      debugPrint('Password is visible');
    } else {
      isPassword.value = true;
      debugPrint('Password is hidden');
    }
  }

  Future<void> forgotPassword() async {
    print('loading');
    await _repo.forgotPassword(emailC.text);
  }

  Future<void> resetPassword() async {
    final data = ResetPasswordModel(
      email: emailC.text,
      password: passwordC.text,
      confirmPassword: confirmPasswordC.text,
      token: tokenC.text,
    );

    await _repo.resetPassword(data);
  }
}
