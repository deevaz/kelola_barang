import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/other/views/delete_account_view.dart';
import 'package:kelola_barang/app/modules/other/views/widgets/profile_info_card.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../../../shared/widgets/change_lang_bottom_sheet.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/other_controller.dart';
import 'widgets/other_info_row.dart';

class OtherView extends GetView<OtherController> {
  const OtherView({super.key});
  @override
  Widget build(BuildContext context) {
    final baseController = Get.put(BaseController());
    final loginC = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorStyle.light,
        title: Text(
          'other'.tr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileInfoCard(),
              SizedBox(height: 20.h),
              Text(
                'profile'.tr,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              MaterialRounded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.sp,
                    horizontal: 10.sp,
                  ),
                  child: Column(
                    children: [
                      OtherInfoRow(
                        title: 'edit-profile'.tr,
                        info: 'edit-profile-desc'.tr,
                        icon: Ionicons.person,
                        suffixIcon: Ionicons.chevron_forward,
                        onTap: () {
                          Get.toNamed('/other/edit-profile');
                        },
                      ),
                      const Divider(),
                      OtherInfoRow(
                        title: 'change-password'.tr,
                        info: 'desc-password'.tr,
                        icon: Ionicons.lock_closed,
                        suffixIcon: Ionicons.chevron_forward,
                        onTap: () {
                          Get.toNamed('/other/change-password');
                        },
                      ),
                      const Divider(),
                      OtherInfoRow(
                        title: 'delete-account'.tr,
                        info: 'desc-delete'.tr,
                        icon: Ionicons.trash,
                        suffixIcon: Ionicons.chevron_forward,
                        onTap: () {
                          print('delete account');
                          Get.to(DeleteAccountView());
                        },
                      ),
                      const Divider(),
                      OtherInfoRow(
                        title: 'forgot-password'.tr,
                        info: 'forgot-password-desc'.tr,
                        icon: Ionicons.lock_open,
                        suffixIcon: Ionicons.chevron_forward,
                        onTap: () {
                          Get.toNamed(Routes.FORGOT_PASSWORD);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'setting'.tr,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              MaterialRounded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.sp,
                    horizontal: 10.sp,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OtherInfoRow(
                        title: 'change-language'.tr,
                        info: 'manage-language'.tr,
                        icon: Ionicons.language,
                        suffixIcon: Ionicons.chevron_forward,
                        onTap: () {
                          Get.bottomSheet(
                            ChangeLangBottomSheet(
                              title: 'change-language'.tr,
                              onTap: (value) {
                                baseController.changeLang(value);
                                Get.back();
                              },
                              selectedLang: baseController.lang.value,
                            ),
                          );
                        },
                      ),
                      const Divider(),
                      OtherInfoRow(
                        title: 'licenses'.tr,
                        info: 'licenses-desc'.tr,
                        suffixIcon: Ionicons.chevron_forward,
                        icon: Ionicons.shield_checkmark,
                        onTap:
                            () => showDialog(
                              context: context,
                              builder:
                                  (BuildContext context) => AboutDialog(
                                    applicationIcon: const Icon(Icons.code),
                                    applicationLegalese:
                                        '© ${DateTime.now().year} Deevaz',
                                    applicationName: 'Kelola Barang',
                                    applicationVersion: '1.0',
                                  ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.danger,
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
      ),
    );
  }
}
