import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/change_lang_bottom_sheet.dart';

class ChangeLanguageBottom extends StatelessWidget {
  const ChangeLanguageBottom({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
