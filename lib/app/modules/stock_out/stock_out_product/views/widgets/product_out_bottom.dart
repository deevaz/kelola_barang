import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/stock_out/stock_out_product/controllers/stock_out_product_controller.dart';
import 'package:kelola_barang/app/services/currency_service.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';

class ProductOutBottom extends StatelessWidget {
  ProductOutBottom({super.key, required this.controller});

  final StockOutProductController controller;

  @override
  Widget build(BuildContext context) {
    CurrencyService format = CurrencyService();
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: ColorStyle.white,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  controller.getProductOut().toString(),
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: ColorStyle.dark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text('product'.tr, style: TextStyle(fontSize: 18.sp)),
            ],
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  format.formatToIdr(controller.getTotalHarga()),
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: ColorStyle.dark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text('total-price'.tr, style: TextStyle(fontSize: 18.sp)),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.saveProductOut();
                  controller.getTotalHarga();
                  Get.back();
                },
                style: EvelatedButtonStyle.rounded15,
                child: Text(
                  'save'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorStyle.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
