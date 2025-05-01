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
  final searchText = ''.obs;
  List<Map<String, dynamic>> get categories => _repo.categories;

  void delProduct(String id) => deleteProduct(id);

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void searchProduct(String query) {
    final lowerQuery = query.toLowerCase();
    final filtered =
        products
            .where(
              (item) => (item.namaBarang?.toString().toLowerCase() ?? "")
                  .contains(lowerQuery),
            )
            .toList();
    products.assignAll(filtered);
  }

  void filterByCategory(String category) async {
    try {
      final data = await _repo.fetchProductbyCategory(category);
      products.assignAll(data);
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
      print('Panjang produk: ${products.length}');
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
        await _repo.deleteProduct(id);
        refreshController.refreshCompleted();
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }
}
