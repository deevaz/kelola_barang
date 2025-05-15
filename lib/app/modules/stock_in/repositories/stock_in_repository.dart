import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';

import 'package:kelola_barang/app/modules/stock_in/models/stock_in_request_model.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:kelola_barang/constants/api_constant.dart';
import 'package:logger/logger.dart';
import '../../base/controllers/base_controller.dart';

class StockInRepository {
  final dio.Dio dioInstance = DioService.dioCall();
  var apiConstant = ApiConstant();
  final userId = BaseController.to.userId.value;
  Logger logger = Logger();

  Future<void> postStockIn(StockInRequestModel data) async {
    try {
      var formData = data.toFormData();
      var response = await dioInstance.post(
        '${apiConstant.BASE_URL}/stockin/$userId',
        data: formData,
      );
      if (response.statusCode == 201) {
        SnackbarService.success('success'.tr, 'stock-in-success'.tr);
        print('Success ${response.data}');
        print('Status Code: ${response.statusCode}');
        Get.offAllNamed('/base');
        HomeController.to.selectedChart.value = 'in';
        HistoryController.to.loadHistory();
      } else if (response.statusCode == 400) {
        SnackbarService.error('failed'.tr, 'stock-in-failed'.tr);
        print('Failed to add stock in: ${response.data}');
      } else {
        print('Failed to add stock in: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error occurred: $e');
      print('Error occurred: $e');
      SnackbarService.error('failed'.tr, 'stock-in-failed'.tr);
    }
  }
}
