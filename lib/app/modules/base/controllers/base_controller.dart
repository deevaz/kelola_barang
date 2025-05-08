import 'dart:ui';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.put(BaseController());

  final RxString name = ''.obs;
  final RxString image = ''.obs;
  final RxString token = ''.obs;
  final RxString userId = ''.obs;
  final Box<UserResponseModel> userBox = Hive.box<UserResponseModel>('user');
  final Box<String> authBox = Hive.box<String>('auth');

  final RxString lang = ''.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
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

  void getUserData() {
    final user = userBox.get('user');
    if (user != null) {
      name.value = user.name;
      image.value =
          user.profilePicture.isNotEmpty
              ? user.profilePicture
              : 'https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png';
      userId.value = user.id.toString();
      email.value = user.email;
    } else {
      name.value = 'Guest';
      image.value =
          'https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_640.png';
      userId.value = '';
      email.value = '';
    }

    token.value = authBox.get('token') ?? '';
  }
}
