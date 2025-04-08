import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  SplashScreenView.lazy({super.key}) {
    Get.lazyPut(() => SplashScreenController());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          child: Image.asset('assets/icons/ic_barangku.png', width: 200.w),
        ),
      ),
    );
  }
}
