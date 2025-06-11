import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/other/forgot_password/views/components/password_text_field.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';

import '../controllers/forgot_password_controller.dart';

class ResetPasswordView extends GetView<ForgotPasswordController> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'reset-password'.tr, lightBg: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PasswordTextField(
                title: 'password'.tr,
                controller: controller.passwordC,
                suffixIcon: Icons.visibility,
                obscureText: true,
              ),
              SizedBox(height: 10.h),
              PasswordTextField(
                title: 'confirm-password'.tr,
                controller: controller.confirmPasswordC,
                suffixIcon: Icons.visibility,
                obscureText: true,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'reset-password'.tr,
                    style: TextStyle(fontSize: 16.sp, color: ColorStyle.white),
                  ),
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    controller.resetPassword();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
