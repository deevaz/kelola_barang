import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/product/controllers/product_controller.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../../../../shared/controllers/barcode_controller.dart';

class EditProductController extends GetxController {
  final barcodeC = Get.put(BarcodeController());

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

  Future<void> scanBarcode() async {
    try {
      final result = await Get.toNamed(Routes.BARCODE_SCANNER);
      if (result != null) {
        print('Kode barcode diambil: $result');
        barcode.value = result;
        kodeBarangC.text = result;
      }
    } catch (e) {
      print('Terjadi error saat scan barcode: $e');
    }
  }

  void loadProductData(Map<String, dynamic> product) {
    kodeBarangC.text = product['kode_barang'] ?? '';
    namaBarangC.text = product['nama_barang'] ?? '';
    stokAwalC.text = product['stok_awal'].toString();
    hargaBeliC.text = product['harga_beli']?.toString() ?? '';
    hargaJualC.text = product['harga_jual']?.toString() ?? '';
    hargaGrosirC.text = product['harga_grosir']?.toString() ?? '';
    selectedCategory.value = product['kategori'] ?? '';
    deskripsiC.text = product['deskripsi'] ?? '';
    selectedImage = Rxn<XFile>();
    selectedDate.value = DateTime.parse(product['kadaluarsa'] ?? '');
    imageUrl.value = product['gambar'];
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

  Future<void> updateProduct(String productId) async {
    print('Updating Product');

    final file = selectedImage.value;
    dio.FormData formData = dio.FormData.fromMap({
      if (file != null)
        'gambar': await dio.MultipartFile.fromFile(
          file.path,
          filename: file.name,
        ),
      'kode_barang':
          barcode.value.isNotEmpty ? barcode.value : kodeBarangC.text,
      'nama_barang': namaBarangC.text,
      'stok_awal': int.tryParse(stokAwalC.text) ?? 0,
      'total_stok': int.tryParse(stokAwalC.text) ?? 0,
      'harga_beli': int.tryParse(hargaBeliC.text) ?? 0,
      'harga_jual': int.tryParse(hargaJualC.text) ?? 0,
      'kadaluarsa': selectedDate.value.toIso8601String(),
      'deskripsi': deskripsiC.text,
      'kategori': selectedCategory.value,
      '_method': 'PUT',
    });

    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};

    try {
      final userId = HomeController.to.userId;
      var dio = Dio();
      var response = await dio.request(
        '${apiConstant.BASE_URL}/products/$userId/$productId',
        options: Options(method: 'POST', headers: headers),
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Product updated successfully');
        print(response.data);
        Get.back();
        Get.back();
        ProductController.to.loadProducts();
        Get.back();
        Get.snackbar(
          'Berhasil',
          'Data barang berhasil diperbarui',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print('Failed to update product');
      }
      print('Success $formData');
    } catch (e) {
      if (e is dio.DioException) {
        print('VALIDATION ERROR: ${e.response?.data}');
      } else {
        print(e);
      }
    }
  }

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2041),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> product = Get.arguments;
    loadProductData(product);
  }
}
