import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../models/change_password.dart';

class ChangePasswordRepository {
  ChangePasswordRepository();
  var apiConstant = ApiConstant();
  final dio = Dio();

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      final token = BaseController.to.token.value;
      var response = await dio.post(
        '${apiConstant.BASE_URL}/change-password',
        options: Options(
          method: 'POST',
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data:
            ChangePassword(
              currentPassword: oldPassword,
              newPassword: newPassword,
              newPasswordConfirmation: newPassword,
            ).toJson(),
      );

      if (response.statusCode == 200) {
        print('Password changed successfully');
        Get.back();
        Get.snackbar(
          'success'.tr,
          'password-changed-successfully'.tr,
          backgroundColor: ColorStyle.success,
          colorText: ColorStyle.white,
          duration: Duration(seconds: 2),
        );
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'error'.tr,
          'unauthorized'.tr,
          backgroundColor: ColorStyle.warning,
          colorText: ColorStyle.white,
          duration: Duration(seconds: 2),
        );
      } else {
        print('Failed to change password: ${response.data}');
        Get.snackbar(
          'error'.tr,
          'failed-to-change-password'.tr,
          backgroundColor: ColorStyle.warning,
          colorText: ColorStyle.white,
          duration: Duration(seconds: 2),
        );
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['error'] ?? 'failed-to-change-password'.tr;

      print('Failed to change password: $errorMessage');
      Get.snackbar(
        'error'.tr,
        errorMessage,
        backgroundColor: ColorStyle.warning,
        colorText: ColorStyle.white,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      print('Unexpected error: $e');
      Get.snackbar(
        'error'.tr,
        'unexpected-error'.tr,
        backgroundColor: ColorStyle.warning,
        colorText: ColorStyle.white,
        duration: Duration(seconds: 2),
      );
    }
  }
}
