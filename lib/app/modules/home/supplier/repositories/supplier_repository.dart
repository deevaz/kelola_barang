import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/home/supplier/controllers/supplier_controller.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:logger/logger.dart';

import '../models/suppliers_model.dart';

class SupplierRepository {
  SupplierRepository();

  final dio.Dio dioInstance = DioService.dioCall();
  Logger log = Logger();

  final userId = BaseController.to.userId.value;

  Future<void> addSupplier(SuppliersModel supplier) async {
    var response = await dioInstance.post('/suppliers/$userId', data: supplier);
    if (response.statusCode == 201) {
      Get.back();
      SnackbarService.success('success'.tr, 'add-supplier-success'.tr);
    } else {
      SnackbarService.error('failed'.tr, 'failed-to-add-supplier'.tr);
      print('Error: ${response.statusMessage}');
    }
  }

  Future<void> editSupplier(SuppliersModel supplier, String id) async {
    var response = await dioInstance.put(
      '/suppliers/$userId/$id',
      data: supplier,
    );
    if (response.statusCode == 201) {
      Get.back();
      SupplierController.to.getAllSuppliers();
      SnackbarService.success('success'.tr, 'change-supplier-success'.tr);
    } else {
      print('Error: ${response.statusMessage}');
      SnackbarService.error('failed'.tr, 'failed-to-change-supplier'.tr);
    }
  }

  // !PASANG MODEL GBLOK
  Future<Iterable<Map<String, dynamic>>> fetchAllSuppliers() async {
    try {
      var dio = Dio();
      var response = await dioInstance.get('/suppliers/$userId');
      print(response.data.toString());
      if (response.statusCode == 200) {
        print('Berhasil ambil data');
        return (response.data['data'] as List).map(
          (item) => item as Map<String, dynamic>,
        );
      } else {
        print('Gagal ambil data');
        return [];
      }
    } catch (e) {
      print('gagal ambil data $e');
      return [];
    }
  }

  Future<void> deleteSupplier(String id) async {
    var response = await dioInstance.delete('/suppliers/$userId/$id');
    print('Supplier deleted successfully');
    if (response.statusCode == 200) {
      SnackbarService.success('success'.tr, 'delete-supplier-success'.tr);
      SupplierController.to.getAllSuppliers();
    } else {
      SnackbarService.error('failed'.tr, 'failed-to-delete-supplier'.tr);
      print('Error: ${response.statusMessage}');
    }
  }
}
