import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/other/views/widgets/profile_card.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/change_lang_bottom_sheet.dart';

import '../../login/controllers/login_controller.dart';
import '../controllers/other_controller.dart';
import 'widgets/custom_container.dart';
import 'widgets/lainnya_info_row.dart';

class OtherView extends GetView<OtherController> {
  const OtherView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final loginC = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'other'.tr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(),
            SizedBox(height: 20.h),
            Text(
              'setting'.tr,
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LainnyaInfoRow(
                    title: 'edit-profile'.tr,
                    info: 'edit-profile-desc'.tr,
                    icon: Ionicons.person,
                    suffixIcon: Ionicons.chevron_forward,
                    onTap: () {
                      Get.toNamed('/other/edit-profile');
                    },
                  ),
                  const Divider(),
                  LainnyaInfoRow(
                    title: 'change-password'.tr,
                    info: 'desc-password'.tr,
                    icon: Ionicons.lock_closed,
                    suffixIcon: Ionicons.chevron_forward,
                    onTap: () {
                      Get.toNamed('/other/change-password');
                    },
                  ),
                  const Divider(),
                  LainnyaInfoRow(
                    title: 'change-language'.tr,
                    info: 'manage-language'.tr,
                    icon: Ionicons.language,
                    suffixIcon: Ionicons.chevron_forward,
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: EdgeInsets.all(15.w),
                          decoration: BoxDecoration(
                            color: ColorStyle.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                          ),
                          child: ChangeLangBottomSheet(
                            title: 'change-language'.tr,
                            onTap: (value) {
                              homeController.changeLang(value);
                              Get.back();
                            },
                            selectedLang: homeController.lang.value,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle.danger,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'logout'.tr,
                    middleText: 'confirm-logout'.tr,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'cancel'.tr,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.primary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          loginC.logout();
                        },
                        child: Text(
                          'yes'.tr,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.danger,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                child: Text(
                  'logout'.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorStyle.white,
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
