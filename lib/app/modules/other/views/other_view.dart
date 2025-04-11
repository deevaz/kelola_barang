import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
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
    final name = homeController.name.value;
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
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorStyle.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'info-account'.tr,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  // Obx(() {
                  //   final bisnis =
                  //       BuatBisnisController.to.bisnis.isNotEmpty
                  //           ? BuatBisnisController.to.bisnis.first
                  //           : null;
                  //   return LainnyaInfoRow(
                  //     title: 'Nama Toko',
                  //     info: bisnis?.namaBisnis ?? 'Nama Toko',
                  //     icon: Icons.shop,
                  //   );
                  // }),
                  SizedBox(height: 15.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              HomeController.to.image.value,
                              width: 70.w,
                              height: 70.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name.toString(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          print('Edit Profile');
                        },
                        icon: Icon(
                          Ionicons.chevron_forward,
                          color: ColorStyle.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            CustomContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'setting'.tr,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  LainnyaInfoRow(
                    title: 'category'.tr,
                    info: 'manage-category'.tr,
                    icon: Ionicons.create,
                  ),
                  SizedBox(height: 15.h),
                  LainnyaInfoRow(
                    title: 'change-language'.tr,
                    info: 'manage-language'.tr,
                    icon: Ionicons.person,
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
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle.danger,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
                    fontSize: 16.sp,
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
