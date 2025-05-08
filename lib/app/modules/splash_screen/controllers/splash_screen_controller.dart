import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    print('SplashScreenController initialized');
    navigateToOnboard();
    super.onInit();
  }

  void navigateToOnboard() async {
    await Future.delayed(const Duration(seconds: 3));
    final userBox = Hive.box<UserResponseModel>('user');
    final user = userBox.get('user');
    if (user != null) {
      Get.offAllNamed('/base');
    } else {
      Get.offAllNamed('/onboarding');
    }
  }
}
