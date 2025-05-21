import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'forgot-password'.tr, lightBg: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(title: 'email'.tr, controller: controller.emailC),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: EvelatedButtonStyle.rounded15,
              onPressed: () {
                controller.forgotPassword();
              },
              child: Text(
                'send'.tr,
                style: TextStyle(fontSize: 16.sp, color: ColorStyle.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
