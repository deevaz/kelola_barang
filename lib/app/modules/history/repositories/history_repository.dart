import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/history/models/history_response_model.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:logger/logger.dart';

class HistoryRepository {
  HistoryRepository();

  final userId = BaseController.to.userId.value;
  var logger = Logger();

  final dio.Dio dioInstance = DioService.dioCall();

  Future<List<HistoryResponseModel>> fetchHistory() async {
    try {
      logger.i('Fetching stock in data for user: $userId');
      var response = await dioInstance.get('/history/$userId');
      logger.d('Response data: ${response.data.toString()}');
      if (response.statusCode == 200) {
        logger.i('History data fetched successfully');
        return (response.data as List)
            .map((item) => HistoryResponseModel.fromJson(item))
            .toList();
      } else {
        logger.e('Failed to fetch History data: ${response.statusMessage}');
        return [];
      }
    } catch (e) {
      logger.e('Error fetching History data: $e');
      return [];
    }
  }

  Future<void> deleteHistory(String id, String tipe) async {
    try {
      if (tipe == 'masuk') {
        var response = await dioInstance.delete('/stockin/$userId/$id');
        if (response.statusCode == 200) {
          SnackbarService.success('success'.tr, 'delete-success'.tr);
        } else {
          SnackbarService.error('error'.tr, 'delete-failed'.tr);
        }
      } else {
        logger.i('Deleting stock out data for user: $userId');
        var response = await dioInstance.delete('/stockout/$userId/$id');
        if (response.statusCode == 200) {
          SnackbarService.success('success'.tr, 'delete-success'.tr);
        } else {
          SnackbarService.error('error'.tr, 'delete-failed'.tr);
          logger.e(
            'Failed to delete stock out data: ${response.statusMessage}',
          );
        }
      }
    } catch (e) {
      logger.e('Error deleting History data: $e');
      SnackbarService.error('error'.tr, 'error-connection'.tr);
    }
  }

  Future<List<HistoryResponseModel>> fetchFilteredHistory(
    String startDate,
    String endDate,
  ) async {
    try {
      logger.i('Fetching filtered stock in data for user: $userId');
      var response = await dioInstance.get(
        '/history/by-date-range/$userId',
        queryParameters: {'start_date': startDate, 'end_date': endDate},
      );
      logger.d('Response data: ${response.data.toString()}');
      if (response.statusCode == 200) {
        logger.i('Filtered History data fetched successfully');
        print('Filtered History data: ${response.data.toString()}');
        return (response.data as List)
            .map((item) => HistoryResponseModel.fromJson(item))
            .toList();
      } else {
        logger.e(
          'Failed to fetch filtered History data: ${response.statusMessage}',
        );
        return [];
      }
    } catch (e) {
      logger.e('Error fetching filtered History data: $e');
      return [];
    }
  }
}
