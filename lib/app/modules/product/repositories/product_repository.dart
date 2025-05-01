import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../models/product_response.dart';

class ProductRepository {
  ProductRepository();

  var apiConstant = ApiConstant();
  final dio = Dio();

  Future<List<ProductResponse>> fetchAllProducts() async {
    try {
      final userId = HomeController.to.userId;
      final token = HomeController.to.token.value;
      var headers = {'Authorization': 'Bearer $token'};
      var response = await dio.request(
        '${apiConstant.BASE_URL}/products/$userId',
        options: Options(method: 'GET', headers: headers),
      );
      print(response.data.toString());
      if (response.statusCode != 200) {
        throw Exception('Failed to load products');
      }

      final List data = response.data['data'];
      return data.map((item) => ProductResponse.fromJson(item)).toList();
    } catch (e) {
      print('gagal ambil data $e');
      return [];
    }
  }

  Future<List<ProductResponse>> fetchProductbyCategory(String category) async {
    try {
      final userId = HomeController.to.userId;
      final token = HomeController.to.token.value;
      var headers = {'Authorization': 'Bearer $token'};
      if (category == 'Semua Kategori') {
        category = '';
      }
      var response = await dio.request(
        '${apiConstant.BASE_URL}/products/$userId/$category',
        options: Options(method: 'GET', headers: headers),
      );
      print(response.data.toString());
      if (response.statusCode != 200) {
        throw Exception('Failed to load products');
      }

      final List data = response.data['data'];
      return data.map((item) => ProductResponse.fromJson(item)).toList();
    } catch (e) {
      print('gagal ambil data $e');
      return [];
    }
  }

  Future<void> deleteProduct(String id) async {
    final token = HomeController.to.token.value;
    var headers = {'Authorization': 'Bearer $token'};
    final userId = HomeController.to.userId;
    var response = await dio.request(
      '${apiConstant.BASE_URL}/products/$userId/$id',
      options: Options(method: 'DELETE', headers: headers),
    );
    print(response.data);
    Get.snackbar(
      'success'.tr,
      'delete-product-succes'.tr,
      backgroundColor: ColorStyle.success,
      colorText: ColorStyle.white,
      duration: Duration(seconds: 2),
    );
  }

  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'Elektronik'},
    {'id': 2, 'name': 'Pakaian'},
    {'id': 3, 'name': 'Peralatan Rumah Tangga'},
    {'id': 4, 'name': 'Buku'},
    {'id': 5, 'name': 'Mainan'},
    {'id': 6, 'name': 'Makanan & Minuman'},
    {'id': 7, 'name': 'Kesehatan & Kecantikan'},
    {'id': 8, 'name': 'Olahraga'},
    {'id': 9, 'name': 'Otomotif'},
    {'id': 10, 'name': 'Peralatan Kantor'},
    {'id': 11, 'name': 'Hobi'},
    {'id': 12, 'name': 'Perhiasan'},
    {'id': 13, 'name': 'Musik'},
    {'id': 14, 'name': 'Fotografi'},
    {'id': 15, 'name': 'Gaming'},
    {'id': 16, 'name': 'Lainnya'},
  ];
}
