import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/stock_out/models/stock_out_model.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:logger/logger.dart';

class StockOutRepository {
  final dio.Dio dioInstance = DioService.dioCall();
  final userId = BaseController.to.userId.value;
  Logger logger = Logger();

  Future<void> postStockOut(StockOutRequestModel data) async {
    try {
      var formData = data.toFormData();
      var response = await dioInstance.post(
        '/stockout/$userId',
        data: formData,
      );
      if (response.statusCode == 201) {
        SnackbarService.success('success'.tr, 'stock-out-success'.tr);
        Get.offAllNamed('/base');
        HomeController.to.selectedChart.value = 'in';
        HistoryController.to.loadHistory();
      } else if (response.statusCode == 400) {
        logger.e('Failed to add stock out: ${response.data}');
        SnackbarService.error('failed'.tr, 'stock-out-failed'.tr);
      } else {
        logger.e('Failed to add stock out: ${response.statusCode}');
        SnackbarService.error('failed'.tr, 'stock-out-failed'.tr);
      }
    } catch (e) {
      logger.e('Error occurred: $e');
      print('Error occurred: $e');
    }
  }
}
