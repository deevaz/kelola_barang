import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/product/controllers/product_controller.dart';
import 'package:kelola_barang/app/modules/product/models/product_request_model.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class EditProductRepo {
  EditProductRepo();
  final dio.Dio dioInstance = DioService.dioCall();
  final api = ApiConstant();

  Future<void> updateProduct(ProductRequestModel product, id) async {
    final userId = BaseController.to.userId.value;
    var formData = await product.toFormData();
    formData.fields.add(MapEntry('_method', 'PUT'));
    final response = await dioInstance.post(
      '/products/$userId/$id',
      data: formData,
    );

    if (response.statusCode == 200) {
      ProductController.to.loadProducts();
      Get.back();
      Get.back();
      SnackbarService.success('success'.tr, 'product-updated'.tr);
    } else {
      print('Failed to update product: ${response.statusCode}');
      print('Response: ${response.data}');
      SnackbarService.error('failed'.tr, 'product-update-failed'.tr);
    }
  }
}
