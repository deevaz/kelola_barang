import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../../controllers/home_controller.dart';
import 'info_widget.dart';

class InfoDataCard extends StatelessWidget {
  InfoDataCard({super.key});
  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final hc = Get.put(HomeController());

    return MaterialRounded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                // 'data '.tr,
                hc.selectedRange.value != null
                    ? 'Data ${DateFormat('dd/MM/yyyy').format(hc.selectedRange.value!.start)} - ${DateFormat('dd/MM/yyyy').format(hc.selectedRange.value!.end)}'
                    : 'total-data'.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.dark,
                ),
              ),
            ),
            const Divider(),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoWidget(
                    title: 'stock-in'.tr,
                    value: hc.stokMasuk.value.toString(),
                    textStyle: TextStyle(
                      fontSize: 35.sp,
                      color: ColorStyle.success,
                    ),
                  ),
                  InfoWidget(
                    title: 'stock-out'.tr,
                    value: hc.stokKeluar.value.toString(),
                    textStyle: TextStyle(
                      fontSize: 35.sp,
                      color: ColorStyle.danger,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Obx(
            //       () => InfoWidget(
            //         title: 'profit'.tr,
            //         value: currencyFormatter.format(hc.profit.value),

            //         textStyle: TextStyle(
            //           fontSize: 22.sp,
            //           color: ColorStyle.dark,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
