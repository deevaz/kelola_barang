import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelola_barang/app/modules/other/edit_profile/views/widgets/edit_profile_picture.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'edit-profile'.tr, lightBg: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: EditProfilePicture(c: controller)),
              SizedBox(height: 5.h),
              CustomTextField(
                title: 'name'.tr,
                controller: controller.nameController,
              ),
              CustomTextField(
                title: 'username'.tr,
                controller: controller.usernameController,
              ),
              CustomTextField(
                title: 'email'.tr,
                controller: controller.emailController,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    controller.updateUser();
                  },
                  child: Text('save'.tr),
                ),
              ),
              SizedBox(height: 300.h),
              Container(
                width: controller.bannerAd.size.width.toDouble(),
                height: controller.bannerAd.size.height.toDouble(),
                child: AdWidget(ad: controller.bannerAd),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
