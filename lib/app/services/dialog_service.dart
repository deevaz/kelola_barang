import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class DialogService {
  static void success({
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.defaultDialog(
      title: 'success'.tr,
      backgroundColor: ColorStyle.white,
      middleText: message,
      onConfirm: onConfirm,
    );
  }

  static void error({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    Get.defaultDialog(
      title: title == '' ? 'error'.tr : title,
      middleText: message,
      backgroundColor: Colors.red.shade100,
      onConfirm: onConfirm ?? () => Get.back(),
    );
  }
}
