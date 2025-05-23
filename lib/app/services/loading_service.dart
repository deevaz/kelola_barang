import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoadingService {
  static void show() {
    if (!(Get.isDialogOpen ?? false)) {
      Get.dialog(
        Center(child: SpinKitFadingCircle(color: Colors.blue, size: 50)),
        barrierDismissible: false,
      );
    }
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
