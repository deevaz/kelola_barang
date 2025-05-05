import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/models/product_response.dart';
import 'package:kelola_barang/app/modules/product/repositories/product_repository.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ProductController extends GetxController {
  static ProductController get to => Get.find();
  final refreshController = RefreshController();
  final ProductRepository _repo = ProductRepository();
  final RxList<ProductResponse> products = <ProductResponse>[].obs;
  final RxList<ProductResponse> filteredProducts = <ProductResponse>[].obs;
  final searchText = ''.obs;
  List<Map<String, dynamic>> get categories => _repo.categories;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void searchProduct(String query) {
    searchText.value = query;
    final lowerQuery = query.toLowerCase();

    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      final filtered =
          products.where((item) {
            final name = item.namaBarang?.toLowerCase() ?? '';
            return name.contains(lowerQuery);
          }).toList();

      filteredProducts.assignAll(filtered);
    }
  }

  void filterByCategory(String category) async {
    try {
      final data = await _repo.fetchProductbyCategory(category);
      filteredProducts.assignAll(data);
      print('Panjang produk: ${filteredProducts.length} $category');
    } catch (e) {
      print('Error loading products: $e');
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> loadProducts() async {
    print('Loading products...');
    try {
      final data = await _repo.fetchAllProducts();
      products.assignAll(data);
      filteredProducts.assignAll(data);
      print('Panjang produk: ${filteredProducts.length}');
    } catch (e) {
      print('Error loading products: $e');
      Get.snackbar('Error', e.toString());
    }
  }

  void onRefresh() async {
    await loadProducts();
    refreshController.refreshCompleted();
  }

  void deleteProduct(String id) {
    Get.defaultDialog(
      title: 'delete-product'.tr,
      middleText: 'are-you-sure'.tr,
      textConfirm: 'yes'.tr,
      textCancel: 'no'.tr,
      confirmTextColor: ColorStyle.white,
      cancelTextColor: ColorStyle.dark,
      buttonColor: ColorStyle.danger,
      onConfirm: () async {
        Get.back();
        await _repo.deleteProduct(id);
      },
      onCancel: () => Get.back(),
    );
  }
}
