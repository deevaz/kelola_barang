import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../controllers/history_controller.dart';
import 'widgets/stock_out_card.dart';
import 'widgets/stock_in_card.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'history'.tr,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorStyle.dark,
                  ),
                ),
                const Spacer(),
                MaterialRounded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_alt_outlined),
                  ),
                ),
                SizedBox(width: 10.w),
                MaterialRounded(
                  child: IconButton(
                    onPressed: () {
                      controller.printDocument();
                      print(controller.stokMasuk);
                      print(controller.stokKeluar);
                    },
                    icon: const Icon(Icons.print),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Obx(() {
                final riwayatList = controller.semuaRiwayat;
                return ListView.builder(
                  itemCount: riwayatList.length,
                  itemBuilder: (context, index) {
                    final riwayat = riwayatList[index];
                    if (riwayat['tipe'] == 'masuk') {
                      return StockInCard(item: riwayat);
                    } else {
                      return StockOutCard(item: riwayat);
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
