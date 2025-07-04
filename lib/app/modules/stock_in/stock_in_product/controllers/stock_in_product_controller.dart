import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/controllers/product_controller.dart';
import 'package:kelola_barang/app/modules/product/models/product_response.dart';
import 'package:kelola_barang/app/modules/stock_in/controllers/stock_in_controller.dart';
import 'package:kelola_barang/app/modules/stock_in/models/product_in_model.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/services/dialog_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:kelola_barang/app/shared/constants/api_constant.dart';
import 'package:logger/web.dart';

import '../views/widgets/stock_in_modal_bottom.dart';

class StockInProductController extends GetxController {
  static StockInProductController get to => Get.find();
  RxString barcode = ''.obs;
  final RxList<ProductInModel> selectedProducts = <ProductInModel>[].obs;
  final RxList<ProductResponse> filteredProducts = <ProductResponse>[].obs;
  final RxList<ProductResponse> products = <ProductResponse>[].obs;
  RxString searchText = ''.obs;
  var apiConstant = ApiConstant();
  RxInt stockIn = 0.obs;
  RxInt price = 0.obs;
  final RxMap<String, int> tempStockChanges = <String, int>{}.obs;

  Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    loadProduct();
  }

  int getProductIn() => selectedProducts.length;

  int getTotalHarga() {
    return selectedProducts.fold(
      0,
      (total, item) => total + (item.harga * item.jumlahstokMasuk),
    );
  }

  void increaseStock(String id) {
    print('tambah stok $id');
    tempStockChanges[id] = (tempStockChanges[id] ?? 0) + 1;
    update();
  }

  void decreaseStock(String id) {
    print('kurang stok $id');
    if ((tempStockChanges[id] ?? 0) > 0) {
      tempStockChanges[id] = tempStockChanges[id]! - 1;
    }
    update();
  }

  void openProductModal(String productId) {
    final existingProduct = selectedProducts.firstWhereOrNull(
      (p) => p.id == productId,
    );

    if (existingProduct != null) {
      tempStockChanges[productId] = existingProduct.jumlahstokMasuk;
    } else {
      tempStockChanges[productId] = 0;
    }

    update();
  }

  void saveProduct(String id) {
    final jumlah = tempStockChanges[id] ?? 0;

    final product = products.firstWhereOrNull((p) => p.id.toString() == id);
    if (product == null) return;

    final existingIndex = selectedProducts.indexWhere((p) => p.id == id);

    if (existingIndex != -1) {
      selectedProducts[existingIndex] = selectedProducts[existingIndex]
          .copyWith(jumlahstokMasuk: jumlah);

      if (jumlah <= 0) {
        selectedProducts.removeAt(existingIndex);
      }
    } else {
      if (jumlah > 0) {
        selectedProducts.add(
          ProductInModel(
            id: id,
            namaBarang: product.namaBarang ?? 'Unknown Product',
            gambar: product.gambar ?? 'https://placehold.co/600x400/png',
            harga: int.tryParse(product.hargaBeli?.toString() ?? '0') ?? 0,
            jumlahstokMasuk: jumlah,
            stok: int.tryParse(product.stok?.toString() ?? '0') ?? 0,
          ),
        );
      }
    }

    if (jumlah > 0) {
      tempStockChanges[id] = jumlah;
    } else {
      tempStockChanges.remove(id);
    }

    update();
  }

  void saveProductIn() {
    final stockInData = StockInController.to.stockInData;
    stockInData
      ..clear()
      ..addAll(selectedProducts);

    StockInController.to.totalPrice.value = getTotalHarga();
    ProductController.to.loadProducts();
  }

  Future<void> scanBarcode() async {
    print('Memulai pemindaian barcode...');
    try {
      final result = await Get.toNamed(Routes.BARCODE_SCANNER);
      if (result != null) {
        print('Kode barcode diambil: $result');
        barcode.value = result;
      }
      searchBarangByBarcode();
    } catch (e) {
      print('Terjadi error saat scan barcode: $e');
    }
  }

  void loadProduct() async {
    RxList<ProductResponse> data = ProductController.to.products;
    if (data.isNotEmpty) {
      filteredProducts.assignAll(data);
      products.assignAll(data);
    } else {
      DialogService.error(title: 'empty'.tr, message: 'product-not-found'.tr);
      print("Tidak ada produk yang ditemukan.");
    }
  }

  void searchProduct(String query) {
    searchText.value = query;
    final lowerQuery = query.toLowerCase();

    filteredProducts.assignAll(
      query.isEmpty
          ? products
          : products.where((item) {
            final name = item.namaBarang?.toLowerCase() ?? '';
            return name.contains(lowerQuery);
          }).toList(),
    );
  }

  void searchBarangByBarcode() {
    try {
      final kode = barcode.value;
      if (kode.isEmpty) return;

      final barang = filteredProducts.firstWhereOrNull(
        (b) => b.kodeBarang == kode,
      );

      if (barang != null) {
        SnackbarService.success(
          'product-found'.tr,
          'Name: ${barang.namaBarang}',
        );
        Get.bottomSheet(_buildStockInModal(barang));
      } else {
        SnackbarService.warning('product-not-found', 'code: $kode');
      }
    } catch (e) {
      print("Error searching product: $e");
    }
  }

  Widget _buildStockInModal(ProductResponse barang) {
    return StockInModalBottom(
      items: barang,
      // onIncrease: () => increaseStock(barang.id!),
      // onDecrease: () => decreaseStock(),
    );
  }
}
