import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../services/product_service.dart';

class ProductController extends GetxController {
  static ProductController get to => Get.find();
  final ProductService _service = ProductService();

  final RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> allProducts = <Map<String, dynamic>>[].obs;
  final searchText = ''.obs;
  final refreshController = RefreshController();

  List<Map<String, dynamic>> get categories => _service.categories;

  void filterProduct(String query) => filterBySearch(query);
  void delProduct(String id) => deleteProduct(id);

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final userId = HomeController.to.userId.toString();
      final data = await _service.fetchAll(userId);
      allProducts.assignAll(data);
      products.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void filterByCategory(String cat) =>
      _filter((item) => item['kategori'] == cat);
  void filterBySearch(String query) => _filter(
    (item) => (item['nama_barang'] as String).toLowerCase().contains(
      query.toLowerCase(),
    ),
  );

  void _filter(bool Function(Map<String, dynamic>) predicate) {
    if (predicate == null) {
      products.assignAll(allProducts);
    } else {
      products.assignAll(allProducts.where(predicate));
    }
  }

  void onRefresh() async {
    await loadProducts();
    refreshController.refreshCompleted();
  }

  void deleteProduct(String id) {
    Get.defaultDialog(
      title: 'Hapus Produk',
      middleText: 'Anda yakin?',
      onConfirm: () async {
        final userId = HomeController.to.userId.toString();
        await _service.delete(userId, id);
        products.removeWhere((it) => it['id'].toString() == id);
        refreshController.refreshCompleted();
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }
}
