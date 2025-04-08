import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final box = Hive.box('user');
  final RxList<UserModel> user = <UserModel>[].obs;

  void printHiveData() {
    final data = box.toMap();
    data.forEach((key, value) {
      print('Key: $key, Value: $value');
    });
  }

  void fetchUserData() {
    final data = box.values.toList();
    user.assignAll(
      data.map((e) => UserModel.fromJson(Map<String, dynamic>.from(e))),
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }
}
