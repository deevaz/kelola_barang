import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../controllers/product_controller.dart';
import '../models/product_response.dart';

class ProductRepository {
  ProductRepository();

  var apiConstant = ApiConstant();
  final dio = Dio();
  final userId = BaseController.to.userId.value;
  final token = BaseController.to.token.value;

  Future<List<ProductResponse>> fetchAllProducts() async {
    try {
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
    final pc = Get.find<ProductController>();
    var headers = {'Authorization': 'Bearer $token'};
    var response = await dio.request(
      '${apiConstant.BASE_URL}/products/$userId/$id',
      options: Options(method: 'DELETE', headers: headers),
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Success',
        'Product deleted successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorStyle.primary,
        colorText: ColorStyle.white,
      );
      fetchAllProducts();
      pc.loadProducts();
    } else {
      Get.snackbar(
        'Error',
        'Failed to delete product: ${response.statusMessage}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: ColorStyle.danger,
        colorText: ColorStyle.white,
      );
    }
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
