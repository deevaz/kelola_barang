import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/password_textfield.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'change-password'.tr, lightBg: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PasswordTextField(
              title: 'old-password'.tr,
              hintText: 'old-password'.tr,
              controller: controller.oldPasswordC,
            ),
            SizedBox(height: 10.h),
            PasswordTextField(
              title: 'new-password'.tr,
              hintText: 'new-password'.tr,
              controller: controller.newPasswordC,
            ),
            SizedBox(height: 10.h),
            PasswordTextField(
              title: 'confirm-password'.tr,
              hintText: 'confirm-password'.tr,
              controller: controller.confirmNewPasswordC,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: EvelatedButtonStyle.rounded15,
                onPressed: () {
                  controller.changePassword();
                },
                child: Text('change-password'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
