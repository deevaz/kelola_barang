import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/detail_product/forgot_password/views/reset_password_view.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';

import '../controllers/forgot_password_controller.dart';

class ConfirmTokenView extends GetView<ForgotPasswordController> {
  const ConfirmTokenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'confirm-token'.tr, lightBg: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Text('confirm-token-desc'.tr, style: TextStyle(fontSize: 16.sp)),
              SizedBox(height: 20.h),
              CustomTextField(title: 'token'.tr, controller: controller.tokenC),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'confirm-token'.tr,
                    style: TextStyle(fontSize: 16.sp, color: ColorStyle.white),
                  ),
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    Get.to(ResetPasswordView());
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
