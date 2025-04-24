import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/shared/models/user_model.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class EditProfileService {
  final Dio _dio = Dio();
  final api = ApiConstant();

  final Box<UserResponseModel> userBox = Hive.box<UserResponseModel>('user');
  final Box<String> authBox = Hive.box<String>('auth');

  Future<UserModel> updateUser(String id, UserModel user, String token) async {
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
    final url = '${api.BASE_URL}/user/$id';

    final options = Options(
      method: 'POST',
      headers: {'Authorization': 'Bearer $token'},
      validateStatus: (_) => true,
    );

    print('➡️ UPDATE USER ➡️ $url');
    print('   Payload: $dataMap');

    final response = await _dio.request(url, options: options, data: formData);

    print('⬅️ Response status: ${response.statusCode}');
    print('⬅️ Response body:   ${response.data}');

    if (response.statusCode == 200) {
      final userJson = response.data['user'] as Map<String, dynamic>;
      Get.snackbar(
        'success'.tr,
        'user-updated-success'.tr,
        backgroundColor: ColorStyle.success,
        colorText: ColorStyle.white,
      );
      userBox.clear();
      final userMap = response.data['user'] as Map<String, dynamic>;
      final user = UserResponseModel.fromJson(userMap);
      await userBox.put('user', user);
      Get.toNamed('/splash-screen');
      return UserModel.fromJson(userJson);
    }

    if (response.statusCode == 422) {
      Get.snackbar(
        'failed'.tr,
        'user-updated-failed'.tr,
        backgroundColor: ColorStyle.danger,
        colorText: ColorStyle.white,
      );
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
