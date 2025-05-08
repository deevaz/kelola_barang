import 'package:dio/dio.dart' as dio;
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/home/models/chart_data_in.dart';
import 'package:kelola_barang/app/modules/home/models/chart_data_out.dart';
import 'package:kelola_barang/app/services/dio_service.dart';

class HomeRepository {
  HomeRepository();

  final dio.Dio dioInstance = DioService.dioCall();

  final userId = BaseController.to.userId;
  final String token = BaseController.to.token.value;

  Future<int> fetchProfit() async {
    final response = await dioInstance.get('/profit/$userId');
    if (response.statusCode == 200) {
      print('Profit: ${response.data}');
      return response.data['total_profit'];
    } else {
      throw Exception(
        'Failed to fetch string from API: ${response.statusMessage}',
      );
    }
  }

  Future<int> fetchFilteredProfit(String startDate, String endDate) async {
    final response = await dioInstance.get(
      '/profit/$userId',
      queryParameters: {'start_date': startDate, 'end_date': endDate},
    );
    if (response.statusCode == 200) {
      print('Filter profit: ${response.data}');
      return response.data['total_profit'];
    } else {
      throw Exception(
        'Failed to fetch string from API: ${response.statusMessage}',
      );
    }
  }

  Future<List<ChartDataIn>> loadFilteredStockIn(
    String startDate,
    String endDate,
  ) async {
    final response = await dioInstance.get(
      '/stock-in/by-date-range/$userId',

      queryParameters: {'start_date': startDate, 'end_date': endDate},
    );
    if (response.statusCode == 200) {
      final List data = response.data;
      print('Filtered Stock In: $data');
      return data.map((e) => ChartDataIn.fromJson(e)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Failed to fetch stock in: ${response.statusMessage}');
    }
  }

  Future<List<ChartDataOut>> loadFilteredStockOut(
    String startDate,
    String endDate,
  ) async {
    final response = await dioInstance.get(
      '/stock-out/by-date-range/$userId',
      queryParameters: {'start_date': startDate, 'end_date': endDate},
    );
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => ChartDataOut.fromJson(e)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Failed to fetch stock out: ${response.statusMessage}');
    }
  }

  Future<List<ChartDataIn>> getStockIn() async {
    final response = await dioInstance.get('/stockin/$userId');
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => ChartDataIn.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch stock in: ${response.statusMessage}');
    }
  }

  Future<List<ChartDataOut>> getStockOut() async {
    final response = await dioInstance.get('/stockout/$userId');
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => ChartDataOut.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch stock out: ${response.statusMessage}');
    }
  }
}
