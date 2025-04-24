import 'package:dio/dio.dart';
import 'package:kelola_barang/app/shared/models/user_model.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class EditProfileService {
  final Dio _dio = Dio();
  final api = ApiConstant();

  Future<UserModel> updateUser(String id, UserModel user, String token) async {
    // 1. Bangun map data manual, exclude password/file yg kosong
    final dataMap = <String, dynamic>{
      'name': user.name,
      'username': user.username,
      'email': user.email,
      '_method': 'PUT',
    };
    if (user.password != null && user.password!.isNotEmpty) {
      dataMap['password'] = user.password;
    }
    if (user.files.isNotEmpty) {
      dataMap['files'] = await Future.wait(
        user.files.map((f) => MultipartFile.fromFile(f.path, filename: f.name)),
      );
    }

    final formData = FormData.fromMap(dataMap);
    final url =
        '${api.BASE_URL}/user/$id'; // pastikan route ini benar di backend

    // 2. Biar kita bisa baca response 422 tanpa auto-throw:
    final options = Options(
      method: 'POST',
      headers: {'Authorization': 'Bearer $token'},
      validateStatus: (_) => true,
    );

    print('➡️ UPDATE USER ➡️ $url');
    print('   Payload: $dataMap');

    final response = await _dio.request(url, options: options, data: formData);

    print('⬅️ Status: ${response.statusCode}');
    print('⬅️ Body:   ${response.data}');

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    }

    if (response.statusCode == 422) {
      // Ambil detail validation errors dari Laravel
      final errs = (response.data['errors'] as Map).map(
        (k, v) => MapEntry(k, (v as List).join(', ')),
      );
      final message = errs.entries
          .map((e) => '${e.key}: ${e.value}')
          .join('\n');
      throw Exception('Validation failed:\n$message');
    }

    throw Exception('HTTP ${response.statusCode}: ${response.statusMessage}');
  }
}
