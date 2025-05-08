import 'package:dio/dio.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class HistoryRepository {
  HistoryRepository();

  var apiConstant = ApiConstant();
  final userId = BaseController.to.userId.value;
  var token = BaseController.to.token.value;

  final dio = Dio();

  Future<Iterable<Map<String, dynamic>>> fetchStokMasuk() async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var response = await dio.request(
        '${apiConstant.BASE_URL}/stockin/$userId',
        options: Options(method: 'GET', headers: headers),
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

  Future<Iterable<Map<String, dynamic>>> fetchStokKeluar() async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var response = await dio.request(
        '${apiConstant.BASE_URL}/stockout/$userId',
        options: Options(method: 'GET', headers: headers),
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

  Future<Iterable<Map<String, dynamic>>> fetchStokMasukByDate(
    String startDate,
    String endDate,
  ) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var response = await dio.request(
        '${apiConstant.BASE_URL}/stock-in/by-date-range/$userId',
        options: Options(method: 'GET', headers: headers),
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
      var headers = {'Authorization': 'Bearer $token'};
      var response = await dio.request(
        '${apiConstant.BASE_URL}/stock-out/by-date-range/$userId',
        options: Options(method: 'GET', headers: headers),
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
