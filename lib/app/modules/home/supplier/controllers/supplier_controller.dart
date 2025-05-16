import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:logger/logger.dart';

import '../models/supplier_model.dart';
import '../repositories/supplier_repository.dart';

class SupplierController extends GetxController {
  static SupplierController get to => Get.find();
  final SupplierRepository repo = SupplierRepository();

  final RxList<SuppliersModel> supplier = <SuppliersModel>[].obs;
  final RxList<SuppliersModel> allSuppliers = <SuppliersModel>[].obs;
  final namaPemasokC = TextEditingController();
  final teleponC = TextEditingController();
  final rekeningC = TextEditingController();
  final catatanC = TextEditingController();
  final searchText = ''.obs;
  Logger log = Logger();

  void filterSupplier(String query) {
    final lowerQuery = query.toLowerCase();
    final filtered =
        allSuppliers
            .where(
              (item) => (item.namaSupplier?.toString().toLowerCase() ?? "")
                  .contains(lowerQuery),
            )
            .toList();
    supplier.assignAll(filtered);
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
    try {
      final data = await repo.fetchAllSuppliers();
      supplier.assignAll(data);
      allSuppliers.assignAll(data);
      log.i('Panjang supplier: ${supplier.length}');
      print('Suppliers fetched ${supplier.length}');
    } catch (e) {
      print("Error fetching suppliers: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllSuppliers();
  }
}
