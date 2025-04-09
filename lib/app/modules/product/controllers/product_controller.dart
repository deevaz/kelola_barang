import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../repositories/product_repository.dart';

class ProductController extends GetxController {
  late final ProductRepository repo;
  final RxList products = [].obs;
  final RefreshController bRefresh = RefreshController(initialRefresh: false);
  var allProducts = [].obs;
  var searchText = ''.obs;
  List<Map<String, dynamic>> get daftarKategori => repo.categories;

  @override
  void onInit() {
    super.onInit();
    repo = ProductRepository();
    getAllProducts();
  }

  void filterByCategory(String kategori) {
    if (kategori.isEmpty) {
      products.assignAll(allProducts);
    } else {
      final filtered =
          allProducts.where((item) => item["kategori"] == kategori).toList();
      products.assignAll(filtered);
    }
  }

  void onRefresh() {
    try {
      getAllProducts();
      bRefresh.refreshCompleted();
      print('Refreshed');
    } catch (e) {
      print(e);
    }
  }

  void filterProduct(String query) {
    final lowerQuery = query.toLowerCase();
    final filtered =
        allProducts
            .where(
              (item) => (item["nama_barang"]?.toString().toLowerCase() ?? "")
                  .contains(lowerQuery),
            )
            .toList();
    products.assignAll(filtered);
  }

  Future<void> getAllProducts() async {
    final fetchedProducts = await repo.fetchAllProducts();
    final listOfData =
        fetchedProducts.map((item) {
          return {
            "id": item["id"],
            "kode_barang": item["kode_barang"],
            "nama_barang": item["nama_barang"],
            "stok_awal": item["stok_awal"],
            "harga_beli": item["harga_beli"],
            "harga_jual": item["harga_jual"],
            "kadaluarsa": item["kadaluarsa"],
            "deskripsi": item["deskripsi"],
            "gambar": item["gambar"],
            "kategori": item["kategori"],
            "total_stok": item["total_stok"],
            "user_id": item["user_id"],
            "created_at": item["created_at"],
            "updated_at": item["updated_at"],
          };
        }).toList();
    products.assignAll(listOfData);
    allProducts.assignAll(listOfData);
    print('Products fetched ${products.length}');
  }

  void delProduct(String id) {
    Get.defaultDialog(
      title: 'Hapus Produk',
      middleText: 'Apakah anda yakin ingin menghapus produk ini?',
      onConfirm: () {
        repo.deleteProduct(id);
        products.removeWhere((item) => item["id"].toString() == id);
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
