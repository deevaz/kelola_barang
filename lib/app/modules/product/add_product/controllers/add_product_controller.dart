import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/controllers/barcode_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../../repositories/product_repository.dart';

class AddProductController extends GetxController {
  static AddProductController get to => Get.put(AddProductController());
  final barcodeC = Get.put(BarcodeController());

  final kodeBarangC = TextEditingController();
  final namaBarangC = TextEditingController();
  final stokAwalC = TextEditingController();
  final hargaBeliC = TextEditingController();
  final hargaJualC = TextEditingController();
  final hargaGrosirC = TextEditingController();
  final deskripsiC = TextEditingController();
  final RxString barcode = ''.obs;

  late final ProductRepository repo;
  List<Map<String, dynamic>> get daftarKategori => repo.categories;

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
      }
      Get.snackbar(
        'Barcode terdeteksi',
        'Kode: $result',
        backgroundColor: ColorStyle.success,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Terjadi error saat scan barcode: $e');
    }
  }

  void addProduct(bool again) async {
    print('Adding Product');

    final file = selectedImage.value;
    dio.FormData formData = dio.FormData.fromMap({
      if (file != null)
        'gambar': await dio.MultipartFile.fromFile(
          file.path,
          filename: file.name,
        ),
      'nama_barang': namaBarangC.text,
      'kode_barang':
          barcode.value.isNotEmpty ? barcode.value : kodeBarangC.text,
      'stok_awal': int.tryParse(stokAwalC.text) ?? 0,
      'total_stok': int.tryParse(stokAwalC.text) ?? 0,
      'harga_beli': int.tryParse(hargaBeliC.text) ?? 0,
      'harga_jual': int.tryParse(hargaJualC.text) ?? 0,
      'deskripsi': deskripsiC.text,
      'kategori': selectedCategory.value,
      'kadaluarsa': selectedDate.value.toIso8601String(),
    });

    postProduct(formData, again);
  }

  Future<void> postProduct(dio.FormData formData, bool again) async {
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};

    try {
      final userId = HomeController.to.userId;
      var dio = Dio();
      var response = await dio.request(
        '${apiConstant.BASE_URL}/products/$userId',
        options: Options(
          method: 'POST',
          headers: headers,
          // headers:
        ),
        data: formData,
      );
      print('Success ${formData}');

      if (response.statusCode == 201) {
        print('Success ${response.data}');
        Get.defaultDialog(
          title: 'Success',
          middleText: 'Product added successfully',
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
        print('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      print('gagal tambah data $e ');
    }
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
      backgroundColor: ColorStyle.success,
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
    repo = ProductRepository();
    fetchCategories();
  }
}
