import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../repositories/supplier_repository.dart';

class SupplierController extends GetxController {
  late final SupplierRepository repo;
  final RxList<Map<String, dynamic>> pemasok = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  final namaPemasokC = TextEditingController();
  final teleponC = TextEditingController();
  final rekeningC = TextEditingController();
  final catatanC = TextEditingController();

  var apiConstant = ApiConstant();

  var searchText = ''.obs;

  final RxList<Map<String, dynamic>> allSuppliers =
      <Map<String, dynamic>>[].obs;

  void filterSupplier(String query) {
    final lowerQuery = query.toLowerCase();
    final filtered =
        allSuppliers
            .where(
              (item) => (item["nama_supplier"]?.toString().toLowerCase() ?? "")
                  .contains(lowerQuery),
            )
            .toList();
    pemasok.assignAll(filtered);
  }

  void addSupplier() async {
    print('Adding supplier...');
    var data = dio.FormData.fromMap({
      'nama_supplier': namaPemasokC.text,
      'no_telp': teleponC.text,
      'no_rekening': rekeningC.text,
      'catatan': catatanC.text,
    });
    print('Data supplier: ${data.toString()}');
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};

    try {
      final userId = HomeController.to.userId;
      var dio = Dio();
      var response = await dio.request(
        '${apiConstant.BASE_URL}/suppliers/$userId',
        options: Options(method: 'POST', headers: headers),
        data: data,
      );

      if (response.statusCode == 201) {
        print('Supplier added successfully');
        clearForm();
        Get.snackbar(
          'Success',
          'Pemasok Berhasil ditambahkan',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Get.back();
        getAllSuppliers();
      } else if (response.statusCode == 422) {
        print('Validation error: ${response.data}');
      } else if (response.statusCode == 401) {
        print('Unauthorized: ${response.data}');
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Failed to add supplier $e');
    }
  }

  void clearForm() {
    namaPemasokC.clear();
    teleponC.clear();
    rekeningC.clear();
    catatanC.clear();
  }

  Future<void> getAllSuppliers() async {
    isLoading.value = true;
    try {
      final fetchedpemasok = await repo.fetchAllSuppliers();
      final listOfpemasok = List<Map<String, dynamic>>.from(fetchedpemasok);
      pemasok.assignAll(listOfpemasok);
      allSuppliers.assignAll(listOfpemasok);
      print('Suppliers fetched ${pemasok.length}');
    } catch (e) {
      print("Error fetching suppliers: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    repo = SupplierRepository();
    getAllSuppliers();
  }
}
