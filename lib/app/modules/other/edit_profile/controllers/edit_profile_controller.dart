import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/other/edit_profile/services/edit_profile_service.dart';
import 'package:kelola_barang/app/shared/models/user_model.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rxn<XFile>();

  final service = EditProfileService();
  final userId = HomeController.to.userId.value;
  final token = HomeController.to.token.value;

  @override
  void onInit() {
    super.onInit();
    setInitialData();
    print("User ID: $userId");
  }

  void setInitialData() {
    final userBox = Hive.box<UserResponseModel>('user');
    final user = userBox.get('user');

    if (user != null) {
      print("Data user ditemukan");
      nameController.text = user.name;
      usernameController.text = user.username;
      emailController.text = user.email;
      print("Name: ${user.name}");
    }
  }

  Future<void> updateUser() async {
    final user = UserModel(
      name: nameController.text,
      username: usernameController.text,
      email: emailController.text,

      files: selectedImage.value != null ? [selectedImage.value!] : [],
    );

    await service.updateUser(user);

    HomeController.to.getUserData();
  }

  Future<void> pickImage(isCamera) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFile != null) {
      selectedImage.value = pickedFile;
    }
  }
}
