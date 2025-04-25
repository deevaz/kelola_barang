import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'change-password'.tr, lightBg: false),
      body: const Center(
        child: Text(
          'ChangePasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
