import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/other/change_password/models/change_password_model.dart';
import 'package:kelola_barang/app/modules/other/change_password/repositories/change_password_repository.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordC = TextEditingController();
  final newPasswordC = TextEditingController();
  final confirmNewPasswordC = TextEditingController();
  final ChangePasswordRepository _repo = ChangePasswordRepository();
  final RxBool isPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    oldPasswordC.dispose();
    newPasswordC.dispose();
    confirmNewPasswordC.dispose();
    super.onClose();
  }

  void showPassword() {
    if (isPassword.value == true) {
      isPassword.value = false;
      debugPrint('Password is visible');
    } else {
      isPassword.value = true;
      debugPrint('Password is hidden');
    }
  }

  void changePassword() {
    String oldPassword = oldPasswordC.text;
    String newPassword = newPasswordC.text;
    String confirmNewPassword = confirmNewPasswordC.text;

    if (oldPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmNewPassword.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'all-fields-required'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }
    if (newPassword != confirmNewPassword) {
      Get.snackbar(
        'error'.tr,
        'passwords-do-not-match'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }

    final data = ChangePasswordModel(
      currentPassword: oldPassword,
      newPassword: newPassword,
      newPasswordConfirmation: confirmNewPassword,
    );

    _repo.changePassword(data);
  }
}
