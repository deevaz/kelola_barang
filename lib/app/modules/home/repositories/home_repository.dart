import 'package:dio/dio.dart' as dio;
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/home/models/chart_data_in.dart';
import 'package:kelola_barang/app/modules/home/models/chart_data_out.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:logger/logger.dart';

class HomeRepository {
  HomeRepository();

  final dio.Dio dioInstance = DioService.dioCall();
  final userId = BaseController.to.userId;
  Logger log = Logger();

  Future<List<ChartDataIn>> fetchFilteredStockIn(
    String startDate,
    String endDate,
  ) async {
    final response = await dioInstance.get(
      '/stock-in/by-date-range/$userId',
      queryParameters: {'start_date': startDate, 'end_date': endDate},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((e) => ChartDataIn.fromJson(e)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Failed to fetch stock in: ${response.statusMessage}');
    }
  }

  Future<List<ChartDataOut>> fetchFilteredStockOut(
    String startDate,
    String endDate,
  ) async {
    final response = await dioInstance.get(
      '/stock-out/by-date-range/$userId',
      queryParameters: {'start_date': startDate, 'end_date': endDate},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((e) => ChartDataOut.fromJson(e)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Failed to fetch stock out: ${response.statusMessage}');
    }
  }

  Future<List<ChartDataIn>> fetchStockIn() async {
    final response = await dioInstance.get('/stockin/$userId');
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => ChartDataIn.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch stock in: ${response.statusMessage}');
    }
  }

  Future<List<ChartDataOut>> fetchStockOut() async {
    final response = await dioInstance.get('/stockout/$userId');
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => ChartDataOut.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch stock out: ${response.statusMessage}');
    }
  }
}
