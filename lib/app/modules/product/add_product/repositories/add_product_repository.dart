import 'package:dio/dio.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class AddProductRepository {
  AddProductRepository();

  var apiConstant = ApiConstant();
  final dio = Dio();
  final userId = HomeController.to.userId.value;
  final token = HomeController.to.token.value;
}
