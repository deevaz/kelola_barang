import 'package:logger/logger.dart'; // Tambahkan import ini
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/shared/constants/api_constant.dart';

class DioService extends GetxService {
  DioService._();

  static final DioService dioService = DioService._();

  static final api = ApiConstant();
  final userId = BaseController.to.userId;

  factory DioService() {
    return dioService;
  }

  static const Duration timeoutInMiliSeconds = Duration(seconds: 200);

  static final Logger logger = Logger();

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
        logger.i('REQUEST URL: ${reqOptions.uri}');
        logger.i('HEADER: ${reqOptions.headers}');
        return handler.next(reqOptions);
      },
      onError: (error, handler) async {
        logger.e('ERROR MESSAGE: ${error.message}');
        logger.e('RESPONSE: ${error.response}');

        if (error.response?.statusCode == 401) {
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
        logger.i('RESPONSE: ${response.data}');
        return handler.resolve(response);
      },
    );
  }
}
