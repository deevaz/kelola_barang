import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/widgets/barcode_button.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/search_widget.dart';
import '../controllers/stock_out_product_controller.dart';
import 'widgets/product_out_bottom.dart';
import 'widgets/select_product_card.dart';
import 'widgets/stock_out_modal_bottom.dart';

class StockOutProductView extends GetView<StockOutProductController> {
  const StockOutProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'select-product'.tr, lightBg: false),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Row(
                children: [
                  Flexible(child: SearchWidget()),

                  BarcodeButton(
                    onTap: () {
                      controller.scanBarcode();
                    },
                  ),
                  SizedBox(width: 5.w),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 120.h),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts;
                  return SelectProductCard(
                    items: product[index],
                    onTap: () {
                      Get.bottomSheet(
                        StockOutModalBottom(items: product[index]),
                      );
                      print('Pilih Barang ${product[index].id}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: ProductOutBottom(controller: controller),
    );
  }
}
