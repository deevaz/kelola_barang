import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/product/controllers/product_controller.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../../controllers/stock_out_controller.dart';
import '../../models/product_out_model.dart';
import '../views/widgets/stock_out_modal_bottom.dart';

class StockOutProductController extends GetxController {
  static StockOutProductController get to => Get.find();
  RxString barcode = ''.obs;
  final RxList selectedProduct = [].obs;
  final RxList listProducts = [].obs;
  final RxList<Map<String, dynamic>> filteredProducts =
      <Map<String, dynamic>>[].obs;
  RxString searchText = ''.obs;
  var apiConstant = ApiConstant();
  RxInt stockOut = 0.obs;
  RxInt price = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadStokDariProduk();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  int getTotalBarang() {
    return selectedProduct.length;
  }

  int getStokKeluar(String idBarang) {
    final barang = selectedProduct.firstWhereOrNull(
      (b) => b['id'].toString() == idBarang,
    );

    if (barang != null && (barang['jumlah_stok_keluar'] ?? 0) > 0) {
      return barang['jumlah_stok_keluar'];
    }

    return 0;
  }

  int getTotalHarga() {
    print("Total harga: ${selectedProduct.length}");
    return selectedProduct.isNotEmpty
        ? selectedProduct.fold(
          0,
          (total, item) =>
              total + ((item['harga'] * item['jumlah_stok_keluar']) as int),
        )
        : 0;
  }

  void searchBarangByBarcode() {
    try {
      final kode = barcode.value;
      if (kode.isEmpty) {
        print("Barcode kosong.");
        return;
      }
      print("Mencari barang dengan barcode: $kode");

      final barang = listProducts.firstWhereOrNull(
        (b) => b['kode_barang'] == kode,
      );

      if (barang != null) {
        print("Barang ditemukan: ${barang['nama_barang']}");
        Get.snackbar(
          'Barang ditemukan',
          'Nama: ${barang['nama_barang']}',
          backgroundColor: ColorStyle.success,
          colorText: ColorStyle.white,
          duration: const Duration(seconds: 5),
        );

        Get.bottomSheet(
          StockOutModalBottom(
            items: barang,
            onIncrease: () {
              tambahStok(barang['id']);
            },
            onDecrease: () {
              kurangStok(barang['id']);
            },
          ),
        );
      } else {
        print("Barang tidak ditemukan.");
        Get.snackbar(
          'Barang tidak ditemukan',
          'Kode: $kode',
          backgroundColor: ColorStyle.warning,
          colorText: ColorStyle.white,
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      print("🧑‍💻Terjadi kesalahan saat mencari barang: $e");
    }
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

  void loadStokDariProduk() async {
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();
    try {
      var response = await dio.request(
        '${apiConstant.BASE_URL}/products/${HomeController.to.userId}',
        options: Options(method: 'GET', headers: headers),
      );

      if (response.statusCode == 200) {
        listProducts.clear();
        listProducts.value = response.data['data'];
        listProducts.refresh();
        print("Data produk berhasil dimuat.");
        print("Data produk: ${listProducts.length} barang.");
      } else {
        print("Gagal memuat data produk: ${response.statusMessage}");
      }
    } catch (e) {
      print("Terjadi kesalahan saat memuat data produk: $e");
    }
  }

  void tambahStok(String idBarang) {
    final barang = listProducts.firstWhereOrNull(
      (b) => b['id']?.toString() == idBarang,
    );
    if (barang != null) {
      int current =
          barang['stok_keluar'] != null
              ? int.tryParse(barang['stok_keluar'].toString()) ?? 0
              : 0;
      current++;
      barang['stok_keluar'] = current;
      listProducts.refresh();

      final existing = selectedProduct.firstWhereOrNull(
        (b) => b['id']?.toString() == idBarang,
      );
      if (existing != null) {
        existing['jumlah_stok_keluar'] = current;
      } else {
        selectedProduct.add({
          'id': barang['id'],
          'gambar': barang['gambar'],
          'nama': barang['nama_barang'],
          'harga': barang['harga_jual'],
          'jumlah_stok_keluar': current,
          'totalStok': barang['total_stok'],
        });
      }
      selectedProduct.refresh();
      print(
        "Stok ditambahkan: ${barang['nama_barang']} - Stok Sekarang: $current",
      );
    }
  }

  void kurangStok(String idBarang) {
    final barang = listProducts.firstWhereOrNull(
      (b) => b['id']?.toString() == idBarang,
    );
    if (barang != null) {
      int current =
          barang['stok_keluar'] != null
              ? int.tryParse(barang['stok_keluar'].toString()) ?? 0
              : 0;
      if (current > 0) {
        current--;
        barang['stok_keluar'] = current;
        listProducts.refresh();
        final existing = selectedProduct.firstWhereOrNull(
          (b) => b['id']?.toString() == idBarang,
        );
        if (existing != null) {
          if (current == 0) {
            selectedProduct.removeWhere((b) => b['id']?.toString() == idBarang);
          } else {
            existing['jumlah_stok_keluar'] = current;
          }
        }
        selectedProduct.refresh();
        print(
          "Stok dikurangi: ${barang['nama_barang']} - Stok Sekarang: $current",
        );
      }
    }
  }

  void simpanStok(String idBarang) {
    final barang = listProducts.firstWhereOrNull(
      (b) => b['id']?.toString() == idBarang,
    );
    if (barang != null) {
      int current =
          barang['stok_keluar'] != null
              ? int.tryParse(barang['stok_keluar'].toString()) ?? 0
              : 0;
      if (current > 0) {
        final existing = selectedProduct.firstWhereOrNull(
          (b) => b['id']?.toString() == idBarang,
        );
        if (existing != null) {
          existing['jumlah_stok_keluar'] = current;
          if (current == 0) {
            selectedProduct.removeWhere((b) => b['id']?.toString() == idBarang);
          }
        } else {
          selectedProduct.add({
            'id': barang['id'],
            'nama': barang['nama_barang'],
            'harga': barang['harga_jual'],
            'jumlah_stok_keluar': current,
            'totalStok': barang['total_stok'],
          });
        }
        print(
          "Stok disimpan: ${barang['nama_barang']} - $current x ${barang['harga_jual']}",
        );
        listProducts.refresh();
        selectedProduct.refresh();
      }
    }
  }

  void savestockOut() {
    final stockOutData = StockOutController.to.stockOutData;
    stockOutData.clear();
    for (var barang in selectedProduct) {
      stockOutData.add(
        ProductOutModel(
          namaBarang: barang['nama'],
          harga: barang['harga'],
          stokKeluar: barang['jumlah_stok_keluar'],
          stok: barang['totalStok'],
          gambar: barang['gambar'] ?? 'https://placehold.co/600x400/png',
        ),
      );
    }
    stockOutData.refresh();
    print("Semua barang disimpan: ${stockOutData.length} barang $stockOutData");

    StockOutController.to.totalPrice.value = selectedProduct.fold(0, (
      total,
      item,
    ) {
      return total + ((item['harga'] * item['jumlah_stok_keluar']) as int);
    });

    Get.lazyPut(() => ProductController());
    ProductController.to.loadProducts();
  }
}
