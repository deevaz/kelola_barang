import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/product/controllers/product_controller.dart';
import 'package:kelola_barang/app/modules/product/models/product_response.dart';
import 'package:kelola_barang/app/modules/product/repositories/product_repository.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/constants/api_constant.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../shared/controllers/barcode_controller.dart';

class EditProductController extends GetxController {
  static EditProductController get to => Get.find();
  late final ProductRepository repo;

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
  final selectedCategory = 'Olahraga'.obs;
  var kategori = <Map<String, dynamic>>[].obs;

  var selectedImage = Rxn<XFile>();
  var imageUrl = Rxn<String>();

  var apiConstant = ApiConstant();

  void fetchCategories() {
    kategori.value = repo.categories;
    print('Kategori: $kategori');
  }

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

  void loadProductData(ProductResponse product) {
    imageUrl.value = product.gambar;
    prepareDownloadedImage(imageUrl.value ?? '');
    kodeBarangC.text = product.kodeBarang ?? '';
    namaBarangC.text = product.namaBarang ?? '';
    stokAwalC.text = product.stokAwal.toString();
    hargaBeliC.text = product.hargaBeli?.toString() ?? '';
    hargaJualC.text = product.hargaJual?.toString() ?? '';
    selectedCategory.value = product.kategori ?? '';
    deskripsiC.text = product.deskripsi ?? '';
    selectedImage = Rxn<XFile>();
    selectedDate.value =
        product.kadaluarsa is DateTime
            ? product.kadaluarsa as DateTime
            : DateTime.now();
    imageUrl.value = product.gambar;
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
      final response = await dio.Dio().request(
        '${apiConstant.BASE_URL}/products/${HomeController.to.userId.value}/$productId',
        options: dio.Options(method: 'POST', headers: headers),
        data: formData,
      );

      if (response.statusCode == 200) {
        Get.back();
        Get.back();
        Get.snackbar(
          'Success',
          'Product updated successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        ProductController.to.loadProducts();
      } else {
        Get.snackbar(
          'Error',
          'Failed to update product: ${response.statusMessage}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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

  Future<void> prepareDownloadedImage(String imageUrl) async {
    final dir = await getTemporaryDirectory();
    final filename = imageUrl.split('/').last;
    final filePath = '${dir.path}/$filename';

    final response = await Dio().download(imageUrl, filePath);
    if (response.statusCode == 200) {
      selectedImage.value = XFile(filePath);
      print('Gambar berhasil diunduh: $filePath');
    } else {
      print('Gagal download gambar');
    }
  }

  @override
  void onInit() {
    super.onInit();
    final ProductResponse product = Get.arguments;
    loadProductData(product);
    repo = ProductRepository();
    fetchCategories();
  }
}
