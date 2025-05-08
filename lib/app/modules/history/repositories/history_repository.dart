import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/history/models/stock_out_response_model.dart';
import 'package:kelola_barang/app/services/dio_service.dart';

import 'package:kelola_barang/constants/api_constant.dart';
import 'package:logger/logger.dart';

import '../models/stock_in_response_model.dart';

class HistoryRepository {
  HistoryRepository();

  var apiConstant = ApiConstant();
  final userId = BaseController.to.userId.value;
  var logger = Logger();

  final dio.Dio dioInstance = DioService.dioCall();

  Future<List<StockInResponseModel>> fetchStokMasuk() async {
    try {
      logger.i('Fetching stock in data for user: $userId');
      var response = await dioInstance.request(
        '/stockin/$userId',
        options: Options(method: 'GET'),
      );
      logger.d('Response data: ${response.data.toString()}');
      if (response.statusCode != 200) {
        logger.e(
          'Failed to load stock in, status code: ${response.statusCode}',
        );
        throw Exception('Failed to load stock in');
      }
      return (response.data as List)
          .map((item) => StockInResponseModel.fromJson(item))
          .toList()
          .cast<StockInResponseModel>();
    } catch (e) {
      logger.e('Error fetching stock in data: $e');
      return [];
    }
  }

  Future<List<StockOutResponseModel>> fetchStokKeluar() async {
    try {
      var response = await dioInstance.request(
        '/stockout/$userId',
        options: Options(method: 'GET'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load stock out');
      }
      return response.data
          .map((item) => StockOutResponseModel.fromJson(item))
          .toList();
    } catch (e) {
      logger.e('Error fetching stock out data: $e');
      return [];
    }
  }

  Future<Iterable<Map<String, dynamic>>> fetchStokMasukByDate(
    String startDate,
    String endDate,
  ) async {
    try {
      var response = await dioInstance.request(
        '/stock-in/by-date-range/$userId',
        options: Options(method: 'GET'),
        queryParameters: {'start_date': startDate, 'end_date': endDate},
      );
      print(response.data.toString());
      if (response.statusCode != 200) {
        throw Exception('Failed to load stock');
      }
      return (response.data as List).map(
        (item) => item as Map<String, dynamic>,
      );
    } catch (e) {
      print('gagal ambil data $e');
      return [];
    }
  }

  Future<Iterable<Map<String, dynamic>>> fetchStokKeluarByDate(
    String startDate,
    String endDate,
  ) async {
    try {
      var response = await dioInstance.request(
        '/stock-out/by-date-range/$userId',
        options: Options(method: 'GET'),
        queryParameters: {'start_date': startDate, 'end_date': endDate},
      );
      print(response.data.toString());
      if (response.statusCode != 200) {
        throw Exception('Failed to load stock out');
      }
      return (response.data as List).map(
        (item) => item as Map<String, dynamic>,
      );
    } catch (e) {
      print('gagal ambil data $e');
      return [];
    }
  }
}
