import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/landing/supplier/controllers/supplier_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../models/suppliers_model.dart';

class SupplierRepository {
  SupplierRepository();

  var apiConstant = ApiConstant();
  final userId = HomeController.to.userId.value;
  final dio = Dio();
  String token = HomeController.to.token.value;

  Future<void> addSupplier(SuppliersModel supplier) async {
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();
    var response = await dio.request(
      '${apiConstant.BASE_URL}/suppliers/$userId',
      options: Options(
        method: 'POST',
        headers: headers,
        contentType: 'application/json',
      ),
      data: supplier,
    );
    if (response.statusCode == 201) {
      Get.snackbar(
        'success'.tr,
        'supplier-added'.tr,
        backgroundColor: ColorStyle.success,
        colorText: ColorStyle.white,
      );
    } else {
      Get.snackbar(
        'failed'.tr,
        'failed-to-add-supplier'.tr,
        backgroundColor: ColorStyle.danger,
        colorText: ColorStyle.white,
      );
    }
  }

  Future<void> editSupplier(SuppliersModel supplier, String id) async {
    var token = HomeController.to.token.value;
    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();
    var response = await dio.request(
      '${apiConstant.BASE_URL}/suppliers/$userId/$id',
      options: Options(
        method: 'PUT',
        headers: headers,
        contentType: 'application/json',
      ),
      data: supplier,
    );
    if (response.statusCode == 201) {
      Get.back();

      SupplierController.to.getAllSuppliers();
      Get.snackbar(
        'success'.tr,
        'change-supplier-success'.tr,
        backgroundColor: ColorStyle.success,
        colorText: ColorStyle.white,
      );
    } else {
      print('Error: ${response.statusCode}');
      print('Error: ${response.data}');
      print('Error: ${response.statusMessage}');
      Get.snackbar(
        'failed'.tr,
        'failed-to-edit-supplier'.tr,
        backgroundColor: ColorStyle.danger,
        colorText: ColorStyle.white,
      );
    }
  }

  Future<Iterable<Map<String, dynamic>>> fetchAllSuppliers() async {
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};
    try {
      var dio = Dio();
      var response = await dio.request(
        '${apiConstant.BASE_URL}/suppliers/$userId',
        options: Options(method: 'GET', headers: headers),
      );
      print(response.data.toString());
      if (response.statusCode != 200) {
        print('Error: ${response.statusCode}');
        Get.snackbar(
          'failed'.tr,
          'failed-to-fetch-data'.tr,
          backgroundColor: ColorStyle.danger,
          colorText: ColorStyle.white,
        );
      } else if (response.data['data'] == null) {
        Get.snackbar(
          'failed'.tr,
          'failed-to-fetch-data'.tr,
          backgroundColor: ColorStyle.danger,
          colorText: ColorStyle.white,
        );
      }
      return (response.data['data'] as List).map(
        (item) => item as Map<String, dynamic>,
      );
    } catch (e) {
      print('gagal ambil data $e');
      return [];
    }
  }

  Future<void> deleteSupplier(String id) async {
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();
    var response = await dio.request(
      '${apiConstant.BASE_URL}/suppliers/$userId/$id',
      options: Options(method: 'DELETE', headers: headers),
    );
    print('Supplier deleted successfully');
    if (response.statusCode == 200) {
      Get.snackbar(
        'Berhasil',
        'Supplier berhasil dihapus',
        backgroundColor: ColorStyle.success,
        colorText: ColorStyle.white,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Supplier gagal dihapus',
        backgroundColor: ColorStyle.danger,
        colorText: ColorStyle.white,
      );
    }
  }
}
