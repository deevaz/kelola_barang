import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/landing/views/widgets/chart_in_widget.dart';
import 'package:kelola_barang/app/modules/landing/views/widgets/chart_out_widget.dart';
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
          controller.getStockIn();
          controller.getStockOut();
          // controller.getHistory();
          print(controller.chartDataIn);
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
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoCard(
                    title: 'Stok Masuk',
                    icon: 'assets/images/img_stok_masuk.png',
                    onTap: () {
                      Get.toNamed(Routes.STOCK_IN);
                      print('Stok Masuk');
                    },
                  ),

                  InfoCard(
                    title: 'Stok Keluar',
                    icon: 'assets/images/img_stok_keluar.png',
                    onTap: () {
                      // Get.toNamed('/stok_keluar');
                      print('Stok Keluar');
                    },
                  ),

                  InfoCard(
                    title: 'Pemasok',
                    onTap: () => Get.toNamed(Routes.SUPPLIER),
                    icon: 'assets/images/img_supplier.png',
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                            ),
                            dropdownColor: ColorStyle.white,
                            items: [
                              DropdownMenuItem(
                                value: 'in',
                                child: Text('Stok Masuk'),
                              ),
                              DropdownMenuItem(
                                value: 'out',
                                child: Text('Stok Keluar'),
                              ),
                            ],
                            value: controller.selectedChart.value,
                            onChanged: (value) {
                              // bc.mataUang.value = value.toString();
                              print('Selected value: $value');
                              controller.selectedChart.value = value.toString();
                              print(
                                'Selected value: ${controller.selectedChart.value}',
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    Obx(() {
                      return controller.selectedChart.value == 'in'
                          ? ChartInWidget()
                          : ChartOutWidget();
                    }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
