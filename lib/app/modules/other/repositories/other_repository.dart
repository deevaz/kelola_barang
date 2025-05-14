import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/services/dialog_service.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';

class OtherRepository {
  OtherRepository();
  final dio.Dio dioInstance = DioService.dioCall();

  Future<void> deleteAccount(String password) async {
    String userId = BaseController.to.userId.value;
    try {
      var data = dio.FormData.fromMap({
        '_method': 'DELETE',
        'password': password,
      });

      var response = await dioInstance.post('/user/$userId', data: data);
      if (response.statusCode == 200) {
        print('berhasil hapus akun');
        DialogService.success(
          message: 'delete-account-success'.tr,
          onConfirm: () {
            Get.offAllNamed('/onboarding');
          },
        );
      } else {
        print('gagal hapus akun');
        SnackbarService.error(
          'error'.tr,
          response.data['message'] ?? 'delete-account-failed'.tr,
        );
      }
    } catch (e) {
      print('gagal hapus akun $e');
    }
  }
}
