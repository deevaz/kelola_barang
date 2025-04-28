import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../../controllers/landing_controller.dart';
import 'info_widget.dart';

class InfoDataCard extends StatelessWidget {
  const InfoDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    final lc = Get.put(LandingController());

    return MaterialRounded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'data'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ColorStyle.dark,
              ),
            ),
            const Divider(),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoWidget(
                    title: 'stock-in'.tr,
                    value: lc.stokMasuk.value.toString(),
                    textStyle: TextStyle(
                      fontSize: 35.sp,
                      color: ColorStyle.success,
                    ),
                  ),
                  InfoWidget(
                    title: 'stock-out'.tr,
                    value: lc.stokKeluar.value.toString(),
                    textStyle: TextStyle(
                      fontSize: 35.sp,
                      color: ColorStyle.danger,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoWidget(
                  title: 'profit'.tr,
                  value: 'Rp. ${lc.omset.value}',
                  textStyle: TextStyle(fontSize: 22.sp, color: ColorStyle.dark),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
