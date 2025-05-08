import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset('assets/images/img_people.png', fit: BoxFit.cover),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 330.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: ColorStyle.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.h),
                  child: Column(
                    children: [
                      SizedBox(height: 25.h),
                      Text(
                        'Kelola Barang',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'deskripsi-judul'.tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40.h,
                            width: 130.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorStyle.dark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed('/login');
                              },
                              child: Text(
                                'login'.tr,
                                style: TextStyle(color: ColorStyle.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          SizedBox(
                            height: 40.h,
                            width: 130.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorStyle.dark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed('/register');
                              },
                              child: Text(
                                'register'.tr,
                                style: TextStyle(color: ColorStyle.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Text.rich(
                        TextSpan(
                          text: 'By continuing, you agree to',
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Term of Service ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorStyle.primary,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: ' Privacy Policy Kelola Barang',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorStyle.primary,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
