import 'package:get/get.dart';

import '../controllers/stock_out_product_controller.dart';

class StockOutProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockOutProductController>(
      () => StockOutProductController(),
    );
  }
}
