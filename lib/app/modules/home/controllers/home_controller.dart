import 'dart:ui';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.put(HomeController());

  final RxString name = ''.obs;
  final RxString image = ''.obs;
  final RxString token = ''.obs;
  final RxString userId = ''.obs;
  final box = Hive.box('user');
  final RxString lang = ''.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    putController();
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void changeLang(String value) {
    lang.value = value;
    Get.updateLocale(Locale(value));
  }

  void putController() {
    switch (tabIndex.value) {
      // case 0:
      //   if (!Get.isRegistered<BerandaController>()) {
      //     Get.put(BerandaController());
      //   }
      //   break;
      // case 1:
      //   if (!Get.isRegistered<BarangController>()) {
      //     Get.put(BarangController());
      //   }
      //   break;
      // case 2:
      //   if (!Get.isRegistered<RiwayatController>()) {
      //     Get.put(RiwayatController());
      //   }
      //   break;
      // case 3:
      //   Get.put(LoginController());
      //   if (!Get.isRegistered<LainnyaController>()) {
      //     Get.put(LainnyaController());
      //   }
      //   break;
      // default:
      //   break;
    }
  }

  void getUserData() {
    final user = box.get('user');
    name.value = user['name'];
    image.value =
        user['profile_picture'] != null
            ? 'http://192.168.2.67:8000/storage/${user['profile_picture']}'
            : 'https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png';
    userId.value = user['id'].toString();
    email.value = user['email'];
    print('Nama user: ${user['name']}');
    print('Email user: ${user['email']}');
    print('ID user: ${user['id']}');
    token.value = box.get('token');
    print('Token: $token');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
