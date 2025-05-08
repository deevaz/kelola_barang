import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/hive_service.dart';
import 'package:kelola_barang/app/services/snackbbar_service.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class RegisterRepository {
  RegisterRepository();

  final dio.Dio dioInstance = DioService.dioCall();
  var apiConstant = ApiConstant();
  final userBox = Hive.box<UserResponseModel>('user');
  final Box<String> authBox = Hive.box<String>('auth');

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
