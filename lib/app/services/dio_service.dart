import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class DioService extends GetxService {
  DioService._();

  static final DioService dioService = DioService._();

  static final api = ApiConstant();
  final userId = BaseController.to.userId;

  factory DioService() {
    return dioService;
  }

  static const Duration timeoutInMiliSeconds = Duration(seconds: 200);

  static Dio dioCall({
    Duration timeout = timeoutInMiliSeconds,

    String? authorization,
  }) {
    String? token = BaseController.to.token.value;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    if (authorization != null) {
      headers['Authorization'] = authorization;
    }

    var dio = Dio(
      BaseOptions(
        headers: headers,
        baseUrl: DioService.api.BASE_URL,
        connectTimeout: timeoutInMiliSeconds,
        contentType: "application/json",
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(_authInterceptor());

    return dio;
  }

  static Interceptor _authInterceptor() {
    return QueuedInterceptorsWrapper(
      onRequest: (reqOptions, handler) {
        log('${reqOptions.uri}', name: 'REQUEST URL');
        log('${reqOptions.headers}', name: 'HEADER');
        return handler.next(reqOptions);
      },
      onError: (error, handler) async {
        log(error.message.toString(), name: 'ERROR MESSAGE');
        log('${error.response}', name: 'RESPONSE');

        if (error.response?.statusCode == 401) {
          // Tangani 401 sebagai response biasa
          return handler.resolve(
            Response(
              requestOptions: error.requestOptions,
              statusCode: 401,
              data: {'message': 'Unauthorized', 'code': 401, 'status': false},
            ),
          );
        }

        return handler.next(error);
      },
      onResponse: (response, handler) async {
        log('${response.data}', name: 'RESPONSE');
        return handler.resolve(response);
      },
    );
  }
}
