import 'package:dio/dio.dart' as dio;

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/product/controllers/product_controller.dart';
import 'package:kelola_barang/app/modules/product/models/product_request_model.dart';
import 'package:kelola_barang/app/services/dialog_service.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:logger/logger.dart';

class AddProductRepository {
  AddProductRepository();
  final dio.Dio dioInstance = DioService.dioCall();
  final userId = BaseController.to.userId.value;
  Logger logger = Logger();

  Future<void> postProduct(ProductRequestModel data, bool again) async {
    try {
      var formData = await data.toFormData();
      var response = await dioInstance.post(
        '/products/$userId',
        options: dio.Options(
          validateStatus: (status) => status != null && status < 500,
        ),
        data: formData,
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
              ProductController.to.loadProducts();
              Get.back();
            } else {
              Get.offAllNamed('/base');
            }
          },
        );
      } else {
        logger.e('Failed to add product: ${response.statusCode}');
        DialogService.error(
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
