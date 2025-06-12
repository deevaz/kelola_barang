import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/product/controllers/product_controller.dart';

import '../controllers/base_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.put(HomeController());
  }
}
