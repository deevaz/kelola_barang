import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart' hide FormData;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snacbbar_service.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../../services/hive_service.dart';
import '../models/user_response_model.dart';

class AuthServices {
  final dio.Dio dioInstance = DioService.dioCall();
  var apiConstant = ApiConstant();
  final userBox = Hive.box<UserResponseModel>('user');
  final Box<String> authBox = Hive.box<String>('auth');

  Future<void> login(String username, String password) async {
    if (password.length < 6) {
      Get.snackbar(
        'login-failed'.tr,
        'minimum-6-character'.tr,
        duration: const Duration(seconds: 2),
        colorText: ColorStyle.white,
        backgroundColor: ColorStyle.danger,
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

  Future<void> postUser(dio.FormData formData) async {
    try {
      final response = await dioInstance.request(
        '/register',
        options: dio.Options(method: 'POST'),
        data: formData,
      );

      if (response.statusCode == 201) {
        final userMap = response.data['user'] as Map<String, dynamic>;
        final user = UserResponseModel.fromJson(userMap);
        await HiveService.saveUser(user);
        await HiveService.saveToken(response.data['token'] as String);
        print(json.encode(response.data));
        Get.offAllNamed('/home');
      } else if (response.statusCode == 422) {
        print('VALIDATION ERROR: ${response.data}');
      } else {
        print(response.statusMessage);
      }
      print('Berhasil mendaftar');
      SnackbarService.success('success'.tr, 'create-account-success'.tr);
    } catch (e) {
      if (e is dio.DioException) {
        if (e.type == dio.DioExceptionType.connectionError) {
          print('Connection Error: ${e.message}');
          SnackbarService.error('failed'.tr, 'connection-error'.tr);
        } else {
          print('VALIDATION ERROR: ${e.response?.data}');
          SnackbarService.error('failed'.tr, 'validation-error'.tr);
        }
      } else {
        print('Unexpected Error: $e');
        SnackbarService.error('failed'.tr, 'unexpected-error'.tr);
      }
    }
  }
}
