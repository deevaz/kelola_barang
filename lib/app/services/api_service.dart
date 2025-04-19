import 'package:dio/dio.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';

class ApiService {
  ApiService._private();
  static final ApiService instance = ApiService._private();

  final Dio _dio = Dio();

  String get _token {
    return HomeController.to.token.value;
  }

  Options get _options => Options(headers: {'Authorization': 'Bearer $_token'});

  Future<Response> getRequest(String path) async {
    return await _dio.get(path, options: _options);
  }

  Future<Response> deleteRequest(String path) async {
    return await _dio.delete(path, options: _options);
  }
}
