import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/stock_in/stock_in_product/controllers/stock_in_product_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';

class StockInModalBottom extends StatelessWidget {
  final Function? onDecrease;
  final Function? onIncrease;
  final dynamic items;

  const StockInModalBottom({
    Key? key,
    this.onDecrease,
    this.onIncrease,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stokMasukBC = StockInProductController.to;
    return Container(
      height: 358.h,
      decoration: BoxDecoration(
        color: ColorStyle.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Center(
            child: Container(
              width: 104,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                Text(
                  'stock-in-total'.tr,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  items['nama_barang'],
                  style: TextStyle(color: ColorStyle.grey, fontSize: 16.sp),
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: ColorStyle.primary,
                        size: 50.r,
                      ),
                      onPressed: () {
                        if (items['id'] != null) {
                          stokMasukBC.kurangStok(items['id']!.toString());
                        }
                      },
                    ),
                    SizedBox(width: 10.w),

                    Obx(() {
                      final stokMasuk = stokMasukBC.getStokMasuk(
                        items['id']!.toString(),
                      );
                      return Text(
                        stokMasuk.toString(),
                        style: TextStyle(
                          fontSize: 50.sp,
                          color: ColorStyle.grey,
                        ),
                      );
                    }),

                    SizedBox(width: 10.w),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 50.r,
                        color: ColorStyle.primary,
                      ),
                      onPressed: () {
                        if (items['id'] != null) {
                          stokMasukBC.tambahStok(items['id']!.toString());
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 70.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyle.warning,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.w,
                            vertical: 15.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Text(
                          'cancel'.tr,
                          style: TextStyle(
                            color: ColorStyle.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // print('${items.id}');
                          // stokMasukBC.simpanStok(items.id!);
                          // stokMasukBC.getTotalBarang();
                          // stokMasukBC.getTotalHarga();

                          // stokMasukBC.selectedProduct.refresh();
                          Get.back();
                        },
                        style: EvelatedButtonStyle.rounded15,
                        child: Text(
                          'save'.tr,
                          style: TextStyle(
                            color: ColorStyle.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
