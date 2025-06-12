import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/constants/ad_constants.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';

import '../../../shared/widgets/password_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  late final BannerAd _bannerAd = BannerAd(
    adUnitId:
        Platform.isAndroid
            ? AdConstants.bannerId
            : 'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        print('Ad loaded.');
      },
      onAdFailedToLoad: (ad, error) {
        print('Ad failed to load: $error');
        ad.dispose();
      },
    ),
  )..load();
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
                SizedBox(height: 20.h),
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
                SizedBox(height: 370.h),
                Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
