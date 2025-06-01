import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelola_barang/app/modules/product/edit_product/repositories/edit_product_repository.dart';
import 'package:kelola_barang/app/modules/product/models/product_request_model.dart';
import 'package:kelola_barang/app/modules/product/models/product_response.dart';
import 'package:kelola_barang/app/modules/product/repositories/product_repository.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/constants/ad_constants.dart';
import 'package:kelola_barang/app/shared/constants/api_constant.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../shared/controllers/barcode_controller.dart';

class EditProductController extends GetxController {
  static EditProductController get to => Get.find();
  late final ProductRepository repo;
  EditProductRepo repoEdit = EditProductRepo();

  final barcodeC = Get.put(BarcodeController());
  final kodeBarangC = TextEditingController();
  final namaBarangC = TextEditingController();
  final stok = TextEditingController();
  final hargaBeliC = TextEditingController();
  final hargaJualC = TextEditingController();
  final hargaGrosirC = TextEditingController();
  final deskripsiC = TextEditingController();

  final RxString barcode = ''.obs;

  late final BannerAd bannerAd = BannerAd(
    adUnitId:
        Platform.isAndroid
            ? AdConstants.bannerId
            : 'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        print('Ad loaded.');
      },
      onAdFailedToLoad: (ad, error) {
        print('Ad failed to load: $error');
        ad.dispose();
      },
    ),
  )..load();

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
    stok.text = product.stok.toString();
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

  void updateProduct(String productId) async {
    print('Updating Product');

    final file = <XFile>[];
    if (selectedImage.value != null) {
      file.add(selectedImage.value!);
    }
    final buyPrice = int.tryParse(hargaBeliC.text.replaceAll('.', ''));
    final sellPrice = int.tryParse(hargaJualC.text.replaceAll('.', ''));
    final product = ProductRequestModel.fromXfiles(
      image: file,
      namaBarang: namaBarangC.text,
      kodeBarang: barcode.value.isNotEmpty ? barcode.value : kodeBarangC.text,
      stok: int.tryParse(stok.text) ?? 0,
      hargaBeli: buyPrice ?? 0,
      hargaJual: sellPrice ?? 0,
      deskripsi: deskripsiC.text,
      kategori: selectedCategory.value,
      kadaluarsa: selectedDate.value.toIso8601String(),
    );
    await repoEdit.updateProduct(product, productId);
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
    final uri = Uri.tryParse(imageUrl);
    if (imageUrl.isEmpty ||
        uri == null ||
        !uri.hasAbsolutePath ||
        uri.host.isEmpty) {
      print('Invalid imageUrl: $imageUrl');
      return;
    }
    try {
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
    } catch (e) {
      print('Exception saat download gambar: $e');
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
