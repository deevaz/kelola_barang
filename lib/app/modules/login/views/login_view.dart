import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';
import 'package:kelola_barang/app/shared/widgets/password_text_field.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 100.h),
          child: Column(
            children: [
              Image.asset('assets/icons/ic_barangku.png', height: 200.h),
              SizedBox(height: 5.h),
              Text(
                'login'.tr,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                'deskripsi-login'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                title: 'Username',
                hintText: 'input-username'.tr,
                controller: controller.usernameController,
              ),
              SizedBox(height: 5.h),
              PasswordTextField(
                title: 'Password',
                hintText: 'input-password'.tr,
                suffixIcon: Icons.visibility,
                obscureText: true,
                controller: controller.passwordController,
              ),

              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () async {
                    final username = controller.usernameController.text;
                    final password = controller.passwordController.text;
                    print('Username: $username');
                    print('Password: $password');
                    if (username.isEmpty || password.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Username dan password tidak boleh kosong',
                      );
                      return;
                    }

                    controller.login(username, password);
                  },
                  child: Text('login'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
