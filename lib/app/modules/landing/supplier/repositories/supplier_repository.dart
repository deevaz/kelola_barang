import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class SupplierRepository {
  SupplierRepository();

  var apiConstant = ApiConstant();
  final userId = HomeController.to.userId.value;
  final dio = Dio();
  String token = HomeController.to.token.value;

  Future<Iterable<Map<String, dynamic>>> fetchAllSuppliers() async {
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};
    try {
      var dio = Dio();
      var response = await dio.request(
        '${apiConstant.BASE_URL}/suppliers/$userId',
        options: Options(method: 'GET', headers: headers),
      );
      print(response.data.toString());
      if (response.statusCode != 200) {
        print('Error: ${response.statusCode}');
        Get.snackbar(
          'Gagal',
          'Gagal mengambil data supplier',
          backgroundColor: ColorStyle.danger,
          colorText: ColorStyle.white,
        );
      } else if (response.data['data'] == null) {
        Get.snackbar(
          'Gagal',
          'Tidak ada data supplier',
          backgroundColor: ColorStyle.danger,
          colorText: ColorStyle.white,
        );
      }
      return (response.data['data'] as List).map(
        (item) => item as Map<String, dynamic>,
      );
    } catch (e) {
      print('gagal ambil data $e');
      return [];
    }
  }

  Future<void> deleteSupplier(String id) async {
    await dio.delete('${apiConstant.BASE_URL}/users/1/suppliers/$id');
  }
}
