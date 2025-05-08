import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../models/change_password_model.dart';

class ChangePasswordRepository {
  ChangePasswordRepository();
  var apiConstant = ApiConstant();
  final dio = Dio();

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      var response = await dio.post(
        '${apiConstant.BASE_URL}/change-password',
        options: Options(method: 'POST'),
        data:
            ChangePasswordModel(
              currentPassword: oldPassword,
              newPassword: newPassword,
              newPasswordConfirmation: newPassword,
            ).toJson(),
      );

      if (response.statusCode == 200) {
        print('Password changed successfully');
        Get.back();
        SnackbarService.success(
          'success'.tr,
          'password-changed-successfully'.tr,
        );
      } else if (response.statusCode == 401) {
        SnackbarService.error('error'.tr, 'unauthorized'.tr);
      } else {
        print('Failed to change password: ${response.data}');
        SnackbarService.error('error'.tr, 'failed-to-change-password'.tr);
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['error'] ?? 'failed-to-change-password'.tr;

      print('Failed to change password: $errorMessage');
      SnackbarService.error('error'.tr, errorMessage);
    } catch (e) {
      print('Unexpected error: $e');
      SnackbarService.error('error'.tr, 'unexpected-error'.tr);
    }
  }
}
