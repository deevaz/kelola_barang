import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

import '../controllers/landing_controller.dart';
import 'widgets/info_card.dart';
import 'widgets/infor_data_card.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.setStokKeluar();
          controller.setStokMasuk();
          // controller.getHistory();
          print(HistoryController.to.stokMasuk.length);
          print(HistoryController.to.stokKeluar.length);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Row(
                children: [
                  Obx(() {
                    final user = HomeController.to.name.value;
                    return RichText(
                      text: TextSpan(
                        text: 'Selamat datang,\n',
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: user.isNotEmpty ? user : '',
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorStyle.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Spacer(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(() {
                      final image = HomeController.to.image.value;
                      if (image.isNotEmpty) {
                        return Image.network(
                          image,
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Icon(
                          Icons.store,
                          size: 40.w,
                          color: ColorStyle.primary,
                        );
                      }
                    }),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              InfoDataCard(),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoCard(
                    title: 'Stok Masuk',
                    icon: 'assets/images/img_stok_masuk.png',
                    onTap: () {
                      // Get.toNamed(Routes.stokMasukRoute);
                      print('Stok Masuk');
                    },
                  ),
                  SizedBox(width: 20.w),
                  InfoCard(
                    title: 'Stok Keluar',
                    icon: 'assets/images/img_stok_keluar.png',
                    onTap: () {
                      // Get.toNamed('/stok_keluar');
                      print('Stok Keluar');
                    },
                  ),
                  SizedBox(width: 20.w),
                  InfoCard(
                    title: 'Pemasok',
                    onTap: () => Get.toNamed(Routes.SUPPLIER),
                    icon: 'assets/images/img_supplier.png',
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // Obx(() {
              //   final riwayat = RiwayatController.to.semuaRiwayat;
              //   if (riwayat.isEmpty) {
              //     return const Center(child: Text('Belum ada data riwayat'));
              //   }
              // return Container(
              //   height: 200.h,
              //   decoration: BoxDecoration(
              //     color: ColorStyle.white,
              //     borderRadius: BorderRadius.circular(15.r),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         spreadRadius: 1,
              //         blurRadius: 1,
              //         offset: const Offset(0, 1),
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       Flexible(child: SizedBox(child: buildChart(riwayat))),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           SizedBox(height: 30.h),
              //           Text(
              //             'Riwayat',
              //             style: TextStyle(
              //               fontSize: 20.sp,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           SizedBox(height: 8.h),
              //           Text(
              //             'Barang Masuk: 100',
              //             // 'Barang Masuk: ${RiwayatController.to.stokMasuk.fold<int>(0, (sum, e) => sum + (e.barang?.fold<int>(0, (s, b) => s + (b.jumlahStokMasuk?.toInt() ?? 0)) ?? 0))}',
              //             style: TextStyle(fontSize: 14.sp),
              //           ),
              //           Text(
              //             'Barang Keluar: 100',
              //             // 'Barang Keluar: ${RiwayatController.to.stokKeluar.fold<int>(0, (sum, e) => sum + (e.barang?.fold<int>(0, (s, b) => s + ((b.jumlahStokKeluar?.toInt() ?? 0))) ?? 0))}',
              //             style: TextStyle(fontSize: 14.sp),
              //           ),
              //         ],
              //       ),
              //       SizedBox(width: 30.w),
              //     ],
              //   ),
              // );
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
