import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    print('SplashScreenController initialized');
    navigateToOnboard();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void navigateToOnboard() async {
    await Future.delayed(const Duration(seconds: 3), () {
      final box = Hive.box('user');
      final token = box.get('token');
      print('Token ditemukan: $token');

      if (token != null && token.toString().isNotEmpty) {
        print('Navigating to Home');
        Get.offAllNamed('/home');
      } else {
        print('Navigating to Onboarding');
        Get.offAllNamed('/onboarding');
      }
    });
  }
}
