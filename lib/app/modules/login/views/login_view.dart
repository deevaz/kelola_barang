import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';
import 'package:kelola_barang/app/modules/login/views/widgets/password_text_field.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 100.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'login'.tr,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'deskripsi-login'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                  title: 'Username',
                  hintText: 'input-username'.tr,
                  controller: controller.usernameController,
                ),
                SizedBox(height: 10.h),
                PasswordTextField(
                  title: 'Password',
                  hintText: 'input-password'.tr,
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                  controller: controller.passwordController,
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    },
                    child: Text(
                      'forgot-password'.tr,
                      style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: EvelatedButtonStyle.rounded15,
                    onPressed: () async {
                      controller.login();
                    },
                    child: Text('login'.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
