import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class ProductRepository {
  ProductRepository();

  var apiConstant = ApiConstant();
  final box = Hive.box('user');
  final RxString token = ''.obs;
  final RxString userId = ''.obs;

  final dio = Dio();

  void getUserData() {
    final user = box.get('user');
    userId.value = user['id'];
    token.value = box.get('token');
    print('Token: $token');
    print('ID user: ${user['id']}');
  }

  Future<Iterable<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      // getUserData();
      var headers = {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzQ0MjE0MzE5LCJleHAiOjE3NDc4MTQzMTksIm5iZiI6MTc0NDIxNDMxOSwianRpIjoiYlA5V1pid2RDNm40N1lNYSIsInN1YiI6IjMiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.0H4tVvfGn5vHONALlRkGmaBJi0bzkMH17T_iXzv3AlQ',
      };
      var response = await dio.request(
        '${apiConstant.BASE_URL}/products/3',
        options: Options(method: 'GET', headers: headers),
      );
      print(response.data.toString());
      if (response.statusCode != 200) {
        throw Exception('Failed to load products');
      }
      return (response.data['data'] as List).map(
        (item) => item as Map<String, dynamic>,
      );
    } catch (e) {
      print('gagal ambil data $e');

      return [];
    }
  }

  Future<void> deleteProduct(String id) async {
    getUserData();
    var headers = {'Authorization': 'Bearer $token'};
    var response = await dio.delete(
      '${apiConstant.BASE_URL}/products/3/$id',
      options: Options(method: 'DELETE', headers: headers),
    );
    print(response.data);
    Get.snackbar(
      'Berhasil',
      'Data berhasil dihapus',
      backgroundColor: ColorStyle.success,
      colorText: ColorStyle.white,
      duration: Duration(seconds: 2),
    );
  }

  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'Elektronik'},
    {'id': 2, 'name': 'Pakaian'},
    {'id': 3, 'name': 'Peralatan Rumah Tangga'},
    {'id': 4, 'name': 'Buku'},
    {'id': 5, 'name': 'Mainan'},
    {'id': 6, 'name': 'Makanan & Minuman'},
    {'id': 7, 'name': 'Kesehatan & Kecantikan'},
    {'id': 8, 'name': 'Olahraga'},
    {'id': 9, 'name': 'Otomotif'},
    {'id': 10, 'name': 'Peralatan Kantor'},
    {'id': 11, 'name': 'Hobi'},
    {'id': 12, 'name': 'Perhiasan'},
    {'id': 13, 'name': 'Musik'},
    {'id': 14, 'name': 'Fotografi'},
    {'id': 15, 'name': 'Gaming'},
    {'id': 16, 'name': 'Lainnya'},
  ];
}
