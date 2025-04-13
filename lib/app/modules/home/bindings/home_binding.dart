import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/product/controllers/product_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ProductController());
    Get.put(HistoryController());
  }
}
