import 'package:dio/dio.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/landing/models/chart_data_in.dart';
import 'package:kelola_barang/app/modules/landing/models/chart_data_out.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class LandingRepository {
  final Dio _dio;
  LandingRepository({Dio? dio}) : _dio = dio ?? Dio();

  final apiConstant = ApiConstant();
  final userId = BaseController.to.userId;
  final String token = BaseController.to.token.value;

  Future<List<ChartDataIn>> loadFilteredStockIn(
    String startDate,
    String endDate,
  ) async {
    final headers = {'Authorization': 'Bearer $token'};

    final response = await _dio.get(
      '${apiConstant.BASE_URL}/stock-in/by-date-range/$userId',
      options: Options(headers: headers),
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
    final headers = {'Authorization': 'Bearer $token'};

    final response = await _dio.get(
      '${apiConstant.BASE_URL}/stock-out/by-date-range/$userId',
      options: Options(headers: headers),
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
    final headers = {'Authorization': 'Bearer $token'};
    final response = await _dio.get(
      '${apiConstant.BASE_URL}/stockin/$userId',
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => ChartDataIn.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch stock in: ${response.statusMessage}');
    }
  }

  Future<List<ChartDataOut>> getStockOut() async {
    final headers = {'Authorization': 'Bearer $token'};
    final response = await _dio.get(
      '${apiConstant.BASE_URL}/stockout/$userId',
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => ChartDataOut.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch stock out: ${response.statusMessage}');
    }
  }
}
