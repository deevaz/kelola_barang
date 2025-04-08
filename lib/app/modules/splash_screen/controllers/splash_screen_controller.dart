import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

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

  void navigateToOnboard() {
    Future.delayed(const Duration(seconds: 3), () {
      print('Navigating to Onboarding');
      Get.offAllNamed('/onboarding');
    });
  }
}
