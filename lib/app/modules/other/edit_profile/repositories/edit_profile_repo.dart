import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/other/edit_profile/models/edit_user_model.dart';
import 'package:kelola_barang/app/services/dialog_service.dart';
import 'package:kelola_barang/app/services/dio_service.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';

class EditProfileRepo {
  EditProfileRepo() {}
  final dio.Dio dioInstance = DioService.dioCall();

  final Box<UserResponseModel> userBox = Hive.box<UserResponseModel>('user');
  final Box<String> authBox = Hive.box<String>('auth');

  Future<EditUserModel> updateUser(EditUserModel user) async {
    final id = BaseController.to.userId.value;
    final dataMap = <String, dynamic>{
      'name': user.name,
      'username': user.username,
      'email': user.email,
    };

    if (user.files.isNotEmpty) {
      dataMap['files'] = await Future.wait(
        user.files.map((f) => MultipartFile.fromFile(f.path, filename: f.name)),
      );
    }

    final formData = FormData.fromMap(dataMap);
    formData.fields.add(MapEntry('_method', 'PUT'));

    final response = await dioInstance.post('/user/edit/$id', data: formData);

    if (response.statusCode == 200) {
      final userJson = response.data['user'] as Map<String, dynamic>;
      SnackbarService.success('success'.tr, 'profile-updated-success'.tr);
      userBox.clear();
      final userMap = response.data['user'] as Map<String, dynamic>;
      final user = UserResponseModel.fromJson(userMap);
      await userBox.put('user', user);
      DialogService.success(
        message: 'update-profile-success'.tr,
        onConfirm: () {
          Get.back();
          Get.offAllNamed('/onboarding');
        },
      );

      Get.toNamed('/splash-screen');
      return EditUserModel.fromJson(userJson);
    }

    if (response.statusCode == 422) {
      SnackbarService.error('error'.tr, 'user-updated-failed'.tr);
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
