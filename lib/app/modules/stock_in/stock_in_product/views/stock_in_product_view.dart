import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/stock_in/stock_in_product/views/widgets/select_product_card.dart';
import 'package:kelola_barang/app/modules/stock_in/stock_in_product/views/widgets/stock_in_modal_bottom.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/barcode_button.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/filter_button.dart';
import 'package:kelola_barang/app/shared/widgets/search_widget.dart';

import '../controllers/stock_in_product_controller.dart';

class StockInProductView extends GetView<StockInProductController> {
  const StockInProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('jumlah pilih: ${controller.selectedProduct.length}');
          print('data: ${controller.selectedProduct}');
          // controller.loadStokDariProduk();
          // controller.getTotalHarga();
          // print(controller.listProducts);
        },
      ),
      appBar: CustomAppBar(title: 'select-product'.tr, lightBg: false),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Row(
                children: [
                  Flexible(child: SearchWidget()),
                  SizedBox(width: 10.w),
                  BarcodeButton(
                    onTap: () {
                      controller.scanBarcode();
                    },
                  ),
                  SizedBox(width: 10.w),
                  FilterButton(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.listProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.listProducts;
                  return SelectProductCard(
                    items: product[index],
                    onTap: () {
                      Get.bottomSheet(
                        StockInModalBottom(
                          items: product[index],
                          onIncrease: () {
                            controller.stockIn.value++;
                            print('Stok Masuk ${controller.stockIn.value}');
                          },
                          onDecrease: () {
                            if (controller.stockIn.value > 0) {
                              controller.stockIn.value--;
                            }
                          },
                        ),
                      );
                      print('Pilih Barang ${product[index]['id']}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100.h,
        decoration: BoxDecoration(
          color: ColorStyle.white,
          boxShadow: [
            BoxShadow(
              color: ColorStyle.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, -1),
            ),
          ],
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
                    controller.getTotalBarang().toString(),
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
                    'RP. ${controller.getTotalHarga()}',
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
                    controller.savestockin();
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
      ),
    );
  }
}
