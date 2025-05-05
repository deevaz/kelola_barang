import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/product/models/product_request.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class AddProductRepository {
  AddProductRepository();

  var apiConstant = ApiConstant();
  final dio = Dio();
  final userId = HomeController.to.userId.value;
  final token = HomeController.to.token.value;

  Future<void> postProduct(ProductRequestModel data, bool again) async {
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};

    try {
      final userId = HomeController.to.userId;
      var dio = Dio();
      var response = await dio.request(
        '${apiConstant.BASE_URL}/products/$userId',
        options: Options(method: 'POST', headers: headers),
        data: data.toJson(),
      );
      print('Success ${response.data}');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 201) {
        print('Success ${response.data}');
        Get.defaultDialog(
          title: 'success'.tr,
          backgroundColor: ColorStyle.success,
          middleText: 'product-saved'.tr,
          onConfirm: () {
            Get.back();
            if (again) {
              Get.back();
            } else {
              Get.offAllNamed('/home');
            }
          },
        );
      } else {
        Get.defaultDialog(
          title: 'failed'.tr,
          middleText: 'product-saved-failed'.tr,
          onConfirm: () {
            Get.back();
          },
        );
        print('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      print('gagal tambah data $e ');
    }
  }
}
