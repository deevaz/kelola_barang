import 'package:kelola_barang/app/services/api_service.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class ProductService {
  final _api = ApiService.instance;
  final _baseUrl = ApiConstant().BASE_URL;

  Future<List<Map<String, dynamic>>> fetchAll(String userId) async {
    final resp = await _api.getRequest('$_baseUrl/products/$userId');
    if (resp.statusCode == 200) {
      return (resp.data['data'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    }
    throw Exception('Failed to fetch products');
  }

  Future<void> delete(String userId, String productId) async {
    await _api.deleteRequest('$_baseUrl/products/$userId/$productId');
  }

  List<Map<String, dynamic>> get categories => const [
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
