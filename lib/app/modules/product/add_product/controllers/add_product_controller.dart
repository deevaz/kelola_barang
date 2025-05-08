import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelola_barang/app/modules/product/add_product/repositories/add_product_repository.dart';

import 'package:kelola_barang/app/modules/product/models/product_request_model.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';

import 'package:kelola_barang/app/shared/controllers/barcode_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../../repositories/product_repository.dart';

class AddProductController extends GetxController {
  static AddProductController get to => Get.put(AddProductController());
  final barcodeC = Get.put(BarcodeController());
  AddProductRepository _addProductRepo = AddProductRepository();
  ProductRepository repo = ProductRepository();

  final kodeBarangC = TextEditingController();
  final namaBarangC = TextEditingController();
  final stokAwalC = TextEditingController();
  final hargaBeliC = TextEditingController();
  final hargaJualC = TextEditingController();
  final hargaGrosirC = TextEditingController();
  final deskripsiC = TextEditingController();
  final RxString barcode = ''.obs;

  final selectedDate = DateTime.now().obs;
  final selectedCategory = ''.obs;
  var kategori = <Map<String, dynamic>>[].obs;

  var selectedImage = Rxn<XFile>();
  var imageUrl = Rxn<String>();

  var apiConstant = ApiConstant();

  void fetchCategories() {
    kategori.value = repo.categories;
  }

  Future<void> scanBarcode() async {
    try {
      final result = await Get.toNamed(Routes.BARCODE_SCANNER);
      if (result != null) {
        print('Kode barcode diambil: $result');
        barcode.value = result;
        kodeBarangC.text = result;
      }
      Get.snackbar(
        'barcode-scanned'.tr,
        'Kode: $result',
        backgroundColor: ColorStyle.success,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'barcode-scan-failed'.tr,
        backgroundColor: ColorStyle.danger,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      print('Terjadi error saat scan barcode: $e');
    }
  }

  void addProduct(bool again) async {
    if (namaBarangC.text.isEmpty ||
        (barcode.value.isEmpty && kodeBarangC.text.isEmpty) ||
        stokAwalC.text.isEmpty ||
        hargaBeliC.text.isEmpty ||
        hargaJualC.text.isEmpty ||
        selectedCategory.value.isEmpty) {
      SnackbarService.error('error'.tr, 'form-is-not-filled'.tr);
      return;
    }

    print('Adding Product');

    final file = <XFile>[];
    if (selectedImage.value != null) {
      file.add(selectedImage.value!);
    }
    final product = ProductRequestModel.fromXfiles(
      image: file,
      namaBarang: namaBarangC.text,
      kodeBarang: barcode.value.isNotEmpty ? barcode.value : kodeBarangC.text,
      stokAwal: int.tryParse(stokAwalC.text) ?? 0,
      totalStok: int.tryParse(stokAwalC.text) ?? 0,
      hargaBeli: int.tryParse(hargaBeliC.text) ?? 0,
      hargaJual: int.tryParse(hargaJualC.text) ?? 0,
      deskripsi: deskripsiC.text,
      kategori: selectedCategory.value,
      kadaluarsa: selectedDate.value.toIso8601String(),
    );
    _addProductRepo.postProduct(product, again);
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(isCamera) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFile != null) {
      selectedImage.value = pickedFile;
    }
  }

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2041),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        selectedDate.value = combinedDateTime;
      }
    }
  }

  void saveItem() {
    Get.snackbar(
      'success'.tr,
      'item-saved'.tr,

      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void saveAndCreateAnother() {
    saveItem();
    resetForm();
  }

  void resetForm() {
    kodeBarangC.clear();
    namaBarangC.clear();
    stokAwalC.clear();
    hargaBeliC.clear();
    hargaJualC.clear();
    hargaGrosirC.clear();
    selectedCategory.value = '';
    deskripsiC.clear();
    selectedImage.value = null;
    selectedDate.value = DateTime.now();
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }
}
