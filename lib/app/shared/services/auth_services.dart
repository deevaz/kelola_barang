import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart' hide FormData;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class AuthServices {
  final dio.Dio dioInstance = dio.Dio();
  var apiConstant = ApiConstant();
  final box = Hive.box('user');
  Future<void> login(String username, String password) async {
    if (password.length < 6) {
      Get.snackbar(
        'login-failed'.tr,
        'minimum-6-character'.tr,
        duration: const Duration(seconds: 2),
        colorText: ColorStyle.white,
        backgroundColor: ColorStyle.danger,
      );
      return null;
    }

    final response = await dioInstance.request(
      '${apiConstant.BASE_URL}/login',
      options: dio.Options(method: 'POST'),
      data: {'username': username, 'password': password},
    );

    if (response.statusCode == 200 && response.data != null) {
      print(json.encode(response.data));

      await box.put('token', response.data['token']);
      await box.put('user', response.data['user']);

      Get.snackbar(
        'login-success'.tr,
        'welcome'.trParams({'name': response.data['user']['name']}),
        duration: const Duration(seconds: 2),
        colorText: ColorStyle.white,
        backgroundColor: ColorStyle.primary,
      );
      Get.offAllNamed('/home');
    } else {
      print('Login failed');
      print(response.statusCode);
      print(response.data);
      print(response.statusMessage);
    }
    return null;
  }

  Future<void> postUser(dio.FormData formData) async {
    try {
      final response = await dioInstance.request(
        '${apiConstant.BASE_URL}/register',
        options: dio.Options(method: 'POST'),
        data: formData,
      );

      if (response.statusCode == 201) {
        await box.put('token', response.data['token']);
        await box.put('user', response.data['user']);
        print(json.encode(response.data));
        Get.offAllNamed('/home');
      } else if (response.statusCode == 422) {
        print('VALIDATION ERROR: ${response.data}');
      } else {
        print(response.statusMessage);
      }
      print('Berhasil mendaftar');
      Get.snackbar(
        'success'.tr,
        'create-account-success'.tr,
        duration: const Duration(seconds: 2),
        colorText: ColorStyle.white,
        backgroundColor: ColorStyle.success,
      );
    } catch (e) {
      if (e is dio.DioException) {
        if (e.type == dio.DioExceptionType.connectionError) {
          print('Connection Error: ${e.message}');
          Get.snackbar(
            'failed'.tr,
            'connection-error'.tr,
            duration: const Duration(seconds: 2),
            colorText: ColorStyle.white,
            backgroundColor: ColorStyle.danger,
          );
        } else {
          print('VALIDATION ERROR: ${e.response?.data}');
          Get.snackbar(
            'failed'.tr,
            'create-account-failed'.tr,
            duration: const Duration(seconds: 2),
            colorText: ColorStyle.white,
            backgroundColor: ColorStyle.danger,
          );
        }
      } else {
        print('Unexpected Error: $e');
        Get.snackbar(
          'failed'.tr,
          'unexpected-error'.tr,
          duration: const Duration(seconds: 2),
          colorText: ColorStyle.white,
          backgroundColor: ColorStyle.danger,
        );
      }
    }
  }
}
