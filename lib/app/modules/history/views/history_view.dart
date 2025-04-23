import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

import '../controllers/history_controller.dart';
import 'widgets/stock_out_card.dart';
import 'widgets/stock_in_card.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'history'.tr,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: ColorStyle.dark,
              ),
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
