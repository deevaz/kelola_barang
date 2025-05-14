import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/other/repositories/other_repository.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';

import 'package:logger/logger.dart';

class OtherController extends GetxController {
  TextEditingController passwordC = TextEditingController();
  final repo = OtherRepository();
  final RxBool hide = true.obs;

  void showPassword() {
    if (hide.value == true) {
      hide.value = false;
      debugPrint('Password is visible');
    } else {
      hide.value = true;
      debugPrint('Password is hidden');
    }
  }

  final logger = Logger();

  void deleteAccount() {
    String password = passwordC.text;
    if (password.isEmpty) {
      SnackbarService.error('error'.tr, 'password-empty'.tr);
      return;
    }
    if (password.length < 6) {
      SnackbarService.error('error'.tr, 'password-min'.tr);
      return;
    }
    repo.deleteAccount(password);
  }
}
