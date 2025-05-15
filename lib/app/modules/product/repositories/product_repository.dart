import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:logger/logger.dart';

import '../controllers/product_controller.dart';
import '../models/product_response.dart';

class ProductRepository {
  ProductRepository();

  final dio.Dio dioInstance = DioService.dioCall();
  Logger log = Logger();

  final userId = BaseController.to.userId.value;

  Future<List<ProductResponse>> fetchAllProducts() async {
    try {
      var response = await dioInstance.get('/products/$userId');
      print(response.data.toString());
      if (response.statusCode == 200) {
        print('berhasil ambil data');
      } else {
        log.e('gagal ambil data', error: response.data);
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
      if (category == 'Semua Kategori') {
        category = '';
      }
      var response = await dioInstance.get('/products/$userId/$category');
      print(response.data.toString());
      if (response.statusCode == 200) {
        print('berhasil ambil data');
      } else {
        log.e('gagal ambil data', error: response.data);
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

    var response = await dioInstance.delete('/products/$userId/$id');

    if (response.statusCode == 200) {
      SnackbarService.success('succes'.tr, 'delete-product-success'.tr);
      fetchAllProducts();
      pc.loadProducts();
    } else {
      SnackbarService.error('error'.tr, 'delete-product-failed'.tr);
      print('gagal hapus data $id');
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
