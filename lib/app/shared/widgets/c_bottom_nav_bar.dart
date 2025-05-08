import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class CBottomNavBar extends StatelessWidget {
  CBottomNavBar({super.key});

  final controller = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorStyle.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorStyle.dark,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: BottomAppBar(
          color: ColorStyle.white,
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavButton(
                  c: controller,
                  title: 'home'.tr,
                  icon: Ionicons.home_outline,
                  tabIndex: 0,
                ),
                NavButton(
                  c: controller,
                  title: 'product'.tr,
                  icon: Icons.inventory_2_outlined,
                  tabIndex: 1,
                ),
                SizedBox(width: 40.w),
                NavButton(
                  c: controller,
                  title: 'history'.tr,
                  icon: Icons.history,
                  tabIndex: 2,
                ),
                NavButton(
                  c: controller,
                  title: 'other'.tr,
                  icon: Ionicons.settings_outline,
                  tabIndex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final BaseController c;
  final int tabIndex;

  const NavButton({
    super.key,
    required this.c,
    required this.title,
    required this.icon,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: () => c.changeTabIndex(tabIndex),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 21.sp,
                  color:
                      c.tabIndex.value == tabIndex
                          ? ColorStyle.primary
                          : ColorStyle.dark,
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color:
                        c.tabIndex.value == tabIndex
                            ? ColorStyle.primary
                            : ColorStyle.dark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
