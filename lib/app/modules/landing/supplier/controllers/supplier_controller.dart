import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

import 'package:kelola_barang/constants/api_constant.dart';

import '../models/suppliers_model.dart';
import '../repositories/supplier_repository.dart';

class SupplierController extends GetxController {
  static SupplierController get to => Get.find();
  late final SupplierRepository repo;
  final isLoading = false.obs;

  final RxList<Map<String, dynamic>> pemasok = <Map<String, dynamic>>[].obs;
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
    final supplier = SuppliersModel(
      namaSupplier: namaPemasokC.text,
      noTelp: teleponC.text,
      noRekening: rekeningC.text,
      catatan: catatanC.text,
    );
    repo.addSupplier(supplier);
  }

  void editSupplier(String id) async {
    print('Editing supplier...');
    final data = SuppliersModel(
      namaSupplier: namaPemasokC.text,
      noTelp: teleponC.text,
      noRekening: rekeningC.text,
      catatan: catatanC.text,
    );
    repo.editSupplier(data, id);
  }

  void deleteSupplier(String id) {
    Get.defaultDialog(
      title: 'delete-supplier'.tr,
      middleText: 'are-you-sure'.tr,
      textConfirm: 'yes'.tr,
      textCancel: 'no'.tr,
      confirmTextColor: ColorStyle.white,
      cancelTextColor: ColorStyle.dark,
      buttonColor: ColorStyle.danger,
      onConfirm: () async {
        Get.back();
        await repo.deleteSupplier(id);
      },
      onCancel: () => Get.back(),
    );
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
