import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class CBottomNavBar extends StatelessWidget {
  CBottomNavBar({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: ColorStyle.dark,
      child: SizedBox(
        height: 60.h,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home_rounded),
                color:
                    controller.tabIndex.value == 0
                        ? ColorStyle.primary
                        : Colors.white,
                onPressed: () => controller.changeTabIndex(0),
              ),
              IconButton(
                icon: const Icon(Icons.inventory),
                color:
                    controller.tabIndex.value == 1
                        ? ColorStyle.primary
                        : Colors.white,
                onPressed: () => controller.changeTabIndex(1),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.history),
                color:
                    controller.tabIndex.value == 2
                        ? ColorStyle.primary
                        : Colors.white,
                onPressed: () => controller.changeTabIndex(2),
              ),
              IconButton(
                icon: const Icon(Icons.abc),
                color:
                    controller.tabIndex.value == 3
                        ? ColorStyle.primary
                        : Colors.white,
                onPressed: () => controller.changeTabIndex(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
