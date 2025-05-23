import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/detail_product/forgot_password/models/reset_password_model.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/loading_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';

import '../views/confirm_token_view.dart';

class ResetPasswordRepository {
  final dio.Dio dioInstance = DioService.dioCall();

  Future<void> forgotPassword(String email) async {
    LoadingService.show();
    try {
      var response = await dioInstance.post(
        '/forgot-password',
        data: dio.FormData.fromMap({'email': email}),
      );
      if (response.statusCode == 200) {
        Get.off(ConfirmTokenView());
        SnackbarService.success('success'.tr, 'check-email'.tr);
        print('Email sent successfully');
        return response.data;
      } else {
        LoadingService.hide();
        SnackbarService.error('error'.tr, 'please-wait'.tr);
        print('Failed to reset password: ${response.statusCode}');
      }
    } catch (e) {
      LoadingService.hide();
      print('Error: $e');
      SnackbarService.error('error'.tr, 'email-not-found'.tr);
    }
  }

  Future<void> resetPassword(ResetPasswordModel data) async {
    LoadingService.show();
    try {
      var response = await dioInstance.post(
        '/reset-password',
        data: data.toJson(),
      );
      if (response.statusCode == 200) {
        Get.toNamed('/login');
        SnackbarService.success('success'.tr, 'reset-password-success'.tr);
      } else if (response.statusCode == 400) {
        LoadingService.hide();
        print('Failed to confirm token: ${response.statusCode}');
        SnackbarService.error('error'.tr, 'confirm-token-not-match'.tr);
      } else {
        LoadingService.hide();
        print('Failed to reset password: ${response.statusCode}');
        SnackbarService.error('error'.tr, 'please-wait'.tr);
      }
    } catch (e) {
      print('Reset Password Error: $e');

      SnackbarService.error('error'.tr, 'confirm-token-not-match'.tr);
    }
  }
}
