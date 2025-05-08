import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class SnackbarService {
  static void success(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      colorText: ColorStyle.white,
      backgroundColor: ColorStyle.success,
    );
  }

  static void error(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      colorText: ColorStyle.white,
      backgroundColor: ColorStyle.danger,
    );
  }

  static void warning(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      colorText: ColorStyle.white,
      backgroundColor: ColorStyle.warning,
    );
  }

  static void info(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: const Duration(seconds: 2),
      colorText: ColorStyle.white,
      backgroundColor: ColorStyle.primary,
    );
  }
}
