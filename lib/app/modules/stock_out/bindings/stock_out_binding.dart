import 'package:get/get.dart';

import '../controllers/stock_out_controller.dart';

class StockOutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockOutController>(
      () => StockOutController(),
    );
  }
}
