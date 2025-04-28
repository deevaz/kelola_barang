import 'dart:convert';

import 'package:dio/dio.dart' as dio;

import 'package:kelola_barang/app/modules/stock_in/models/stock_in_model.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class StockInService {
  final dio.Dio dioInstance = dio.Dio();
  var apiConstant = ApiConstant();

  Future<dio.Response> postStockIn({
    required String userId,
    required String token,
    required StockInModel data,
  }) {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    return dioInstance.request(
      '${apiConstant.BASE_URL}/stockin/$userId',
      data: json.encode(data.toJson()),
      options: dio.Options(headers: headers),
    );
  }
}
