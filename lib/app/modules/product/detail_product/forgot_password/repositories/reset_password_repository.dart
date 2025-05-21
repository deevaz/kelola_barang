import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/detail_product/forgot_password/models/reset_password_model.dart';

import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';

import '../views/confirm_token_view.dart';

class ResetPasswordRepository {
  final dio.Dio dioInstance = DioService.dioCall();

  Future<void> forgotPassword(String email) async {
    try {
      var response = await dioInstance.post(
        '/forgot-password',
        data: dio.FormData.fromMap({'email': email}),
      );
      if (response.statusCode == 200) {
        Get.to(ConfirmTokenView());
        SnackbarService.success('success'.tr, 'check-email'.tr);
        print('Email sent successfully');
        return response.data;
      } else {
        print('Failed to reset password: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(ResetPasswordModel data) async {
    try {
      var response = await dioInstance.post(
        '/reset-password',
        data: data.toJson(),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Failed to confirm token: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
