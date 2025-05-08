import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/views/history_view.dart';
import 'package:kelola_barang/app/modules/home/views/home_view.dart';
import 'package:kelola_barang/app/modules/other/views/other_view.dart';
import 'package:kelola_barang/app/modules/product/views/product_view.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/c_bottom_nav_bar.dart';

import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [HomeView(), ProductView(), HistoryView(), OtherView()],
        ),
      ),
      bottomNavigationBar: CBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Tambah Barang');
          Get.toNamed(Routes.ADD_PRODUCT);
        },
        backgroundColor: ColorStyle.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Icon(Icons.add, color: ColorStyle.white, size: 30.w),
      ),
    );
  }
}
