import 'package:dio/dio.dart' as dio;

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/product/models/product_request.dart';
import 'package:kelola_barang/app/services/dialog_service.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class AddProductRepository {
  AddProductRepository();
  final dio.Dio dioInstance = DioService.dioCall();
  final userId = BaseController.to.userId.value;
  String token = BaseController.to.token.value;

  Future<void> postProduct(ProductRequestModel data, bool again) async {
    try {
      var response = await dioInstance.request(
        '/products/$userId',
        options: dio.Options(
          method: 'POST',
          validateStatus: (status) => status != null && status < 500,
        ),
        data: data.toJson(),
      );
      print('Success ${response.data}');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 201) {
        print('Success ${response.data}');
        Get.defaultDialog(
          title: 'success'.tr,
          backgroundColor: ColorStyle.white,
          middleText: 'product-saved'.tr,
          onConfirm: () {
            Get.back();
            if (again) {
              Get.back();
            } else {
              Get.offAllNamed('/base');
            }
          },
        );
      } else {
        DialogService.showError(
          title: 'failed'.tr,
          message: 'product-saved-failed'.tr,
          onConfirm: () {
            Get.back();
          },
        );

        print('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
