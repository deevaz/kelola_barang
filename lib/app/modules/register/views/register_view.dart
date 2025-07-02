import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelola_barang/app/modules/register/views/widget/add_profile_image.dart';
import 'package:kelola_barang/app/shared/constants/ad_constants.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';
import 'package:kelola_barang/app/shared/widgets/password_textfield.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 100.h),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Text(
                'register'.tr,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                'deskripsi-register'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.h),
              AddProfileImage(),
              SizedBox(height: 10.h),
              CustomTextField(
                title: 'name'.tr,
                hintText: 'input-name'.tr,
                controller: controller.nameController,
              ),
              CustomTextField(
                title: 'username'.tr,
                hintText: 'input-username'.tr,
                controller: controller.usernameC,
              ),
              CustomTextField(
                title: 'email'.tr,
                hintText: 'input-email'.tr,
                controller: controller.emailController,
              ),
              SizedBox(height: 10.h),
              PasswordTextField(
                title: 'password'.tr,
                hintText: 'input-password'.tr,
                controller: controller.passwordController,
              ),
              SizedBox(height: 10.h),
              PasswordTextField(
                title: 'confirm-password'.tr,
                hintText: 'input-password'.tr,
                controller: controller.cpasswordController,
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    controller.register();
                  },
                  child: Text('Daftar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
