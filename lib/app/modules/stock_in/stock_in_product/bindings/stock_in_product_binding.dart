import 'package:get/get.dart';

import '../controllers/stock_in_product_controller.dart';

class StockInProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockInProductController>(
      () => StockInProductController(),
    );
  }
}
