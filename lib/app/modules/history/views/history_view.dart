import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

import '../controllers/history_controller.dart';
import 'widgets/keluar_card.dart';
import 'widgets/masuk_card.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getHistory();
          print(controller.stokMasuk.length);
          print(controller.stokKeluar.length);
        },
      ),
      appBar: AppBar(
        backgroundColor: ColorStyle.light,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Riwayat',
            style: TextStyle(
              fontSize: 18.sp,
              color: ColorStyle.dark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          color: ColorStyle.dark,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          final riwayatList = controller.semuaRiwayat;
          return ListView.builder(
            itemCount: riwayatList.length,
            itemBuilder: (context, index) {
              final riwayat = riwayatList[index];
              if (riwayat['tipe'] == 'masuk') {
                return MasukCard(item: riwayat);
              } else {
                return KeluarCard(item: riwayat);
              }
            },
          );
        }),
      ),
    );
  }
}
