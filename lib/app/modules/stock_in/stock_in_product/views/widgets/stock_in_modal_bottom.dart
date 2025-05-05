import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/stock_in/stock_in_product/controllers/stock_in_product_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';

class StockInModalBottom extends StatelessWidget {
  final Function? onDecrease;
  final Function? onIncrease;
  final VoidCallback? onClose;
  final dynamic items;

  const StockInModalBottom({
    Key? key,
    this.onDecrease,
    this.onIncrease,
    this.onClose,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stokMasukBC = StockInProductController.to;
    return WillPopScope(
      onWillPop: () async {
        if (onClose != null) onClose!();
        return true;
      },
      child: Container(
        height: 358.h,
        decoration: BoxDecoration(
          color: ColorStyle.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Container(
              width: 104,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'stock-in-total'.tr,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
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
                    size: 50.r,
                    color: ColorStyle.primary,
                  ),
                  onPressed:
                      () => stokMasukBC.kurangStokSementara(
                        items['id'].toString(),
                      ),
                ),
                SizedBox(width: 10.w),
                Obx(() {
                  final stok =
                      stokMasukBC.tempStockChanges[items['id'].toString()] ??
                      stokMasukBC.getStokMasuk(items['id'].toString());
                  return Text(
                    stok.toString(),
                    style: TextStyle(fontSize: 50.sp, color: ColorStyle.grey),
                  );
                }),
                SizedBox(width: 10.w),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 50.r,
                    color: ColorStyle.primary,
                  ),
                  onPressed:
                      () => stokMasukBC.tambahStokSementara(
                        items['id'].toString(),
                      ),
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
                    onPressed: () {
                      stokMasukBC.tempStockChanges.remove(
                        items['id'].toString(),
                      );
                      if (onClose != null) onClose!();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyle.warning,
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
                      stokMasukBC.simpanStok(items['id'].toString());
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
    );
  }
}
