import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelola_barang/app/shared/models/user_model.dart';
import 'package:kelola_barang/app/shared/services/auth_services.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class RegisterController extends GetxController {
  final usernameC = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final RxBool isPassword = true.obs;
  var selectedImage = Rxn<XFile>();
  var apiConstant = ApiConstant();
  final box = Hive.box('user');
  final ImagePicker _picker = ImagePicker();
  final AuthServices _authService = AuthServices();

  void showPassword() {
    if (isPassword.value == true) {
      isPassword.value = false;
      print('Password is visible');
    } else {
      isPassword.value = true;
      print('Password is hidden');
    }
  }

  Future<void> pickImage(isCamera) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickedFile != null) {
      selectedImage.value = pickedFile;
    }
  }

  void register() async {
    print('Sedang daftar');

    if (passwordController.text != cpasswordController.text) {
      Get.snackbar(
        'failed'.tr,
        'password-not-match'.tr,
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    if (passwordController.text.length < 6) {
      Get.snackbar(
        'failed'.tr,
        'minimum-6-character'.tr,
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    final files = <XFile>[];
    if (selectedImage.value != null) {
      files.add(selectedImage.value!);
    }

    final user = UserModel.fromXFiles(
      files: files,
      name: nameController.text.trim(),
      username: usernameC.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    final formData = await user.toFormData();

    await _authService.postUser(formData);
  }
}
