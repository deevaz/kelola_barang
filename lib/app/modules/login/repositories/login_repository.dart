import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/hive_service.dart';
import 'package:kelola_barang/app/services/snacbbar_service.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class LoginRepository {
  LoginRepository();

  final dio.Dio dioInstance = DioService.dioCall();
  var apiConstant = ApiConstant();
  final userBox = Hive.box<UserResponseModel>('user');
  final Box<String> authBox = Hive.box<String>('auth');

  Future<void> login(String username, String password) async {
    if (password.length < 6) {
      SnackbarService.error(
        'login-failed'.tr,
        'password-minimum'.trParams({'min': '6'}),
      );
      return;
    }

    final response = await dioInstance.request(
      '/login',
      options: dio.Options(
        method: 'POST',
        validateStatus: (status) => status != null && status < 500,
      ),
      data: {'username': username, 'password': password},
    );

    if (response.statusCode == 200 && response.data != null) {
      print(json.encode(response.data));

      final userMap = response.data['user'] as Map<String, dynamic>;
      final user = UserResponseModel.fromJson(userMap);
      await HiveService.saveUser(user);
      await HiveService.saveToken(response.data['token'] as String);

      SnackbarService.success(
        'login-success'.tr,
        'welcome'.trParams({'name': user.name}),
      );
      Get.offAllNamed('/home');
    } else if (response.statusCode == 401) {
      print('Invalid credentials');
      print(response.data);
      SnackbarService.error('login-failed'.tr, 'invalid-credentials'.tr);
    } else if (response.statusCode == 404) {
      SnackbarService.error('login-failed'.tr, 'username-not-found'.tr);
    } else if (response.statusCode == 500) {
      SnackbarService.error('login-failed'.tr, 'server-error'.tr);
    } else {
      print('Login failed');
      print(response.statusCode);
      print(response.data);
      print(response.statusMessage);
    }
    return;
  }
}
