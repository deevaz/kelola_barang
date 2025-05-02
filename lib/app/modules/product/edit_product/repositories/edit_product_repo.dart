import 'package:dio/dio.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/product/models/product_request.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class EditProductRepo {
  EditProductRepo();
  final Dio _dio = Dio();
  final api = ApiConstant();

  Future<void> updateProduct({required ProductRequestModel product, id}) async {
    final userId = HomeController.to.userId.value;
    final token = HomeController.to.token.value;

    final formData = FormData.fromMap({
      if (product.imageFile != null)
        'gambar': await MultipartFile.fromFile(
          product.imageFile!.path,
          filename: product.imageFile!.path.split('/').last,
        ),
      'kode_barang': product.kodeBarang,
      'nama_barang': product.namaBarang,
      'stok_awal': product.stokAwal,
      'total_stok': product.stokAwal,
      'harga_beli': product.hargaBeli,
      'harga_jual': product.hargaJual,
      'kadaluarsa': product.kadaluarsa,
      'deskripsi': product.deskripsi,
      'kategori': product.kategori,
      '_method': 'PUT',
    });

    final response = await _dio.request(
      '${api.BASE_URL}/products/$userId/$id',
      options: Options(
        method: 'POST',
        headers: {'Authorization': 'Bearer $token'},
      ),
      data: formData,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product: ${response.data}');
    }
  }
}
