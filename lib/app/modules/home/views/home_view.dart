import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/views/history_view.dart';
import 'package:kelola_barang/app/modules/landing/views/landing_view.dart';
import 'package:kelola_barang/app/modules/other/views/other_view.dart';
import 'package:kelola_barang/app/modules/product/views/product_view.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/c_bottom_nav_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [LandingView(), ProductView(), HistoryView(), OtherView()],
        ),
      ),
      bottomNavigationBar: CBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Tambah Barang');
          Get.toNamed('/tambah_barang');
        },
        backgroundColor: ColorStyle.primary,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: ColorStyle.white),
      ),
    );
  }
}
