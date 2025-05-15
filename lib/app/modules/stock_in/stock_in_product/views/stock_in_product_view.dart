import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/stock_in/stock_in_product/views/widgets/product_in_card.dart';
import 'package:kelola_barang/app/modules/stock_in/stock_in_product/views/widgets/stock_in_modal_bottom.dart';
import 'package:kelola_barang/app/shared/widgets/barcode_button.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/search_widget.dart';

import '../controllers/stock_in_product_controller.dart';
import 'widgets/product_in_bottom.dart';

class StockInProductView extends GetView<StockInProductController> {
  const StockInProductView({super.key});
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
                  Flexible(
                    child: SearchWidget(
                      onChanged: (value) {
                        controller.searchProduct(value);
                        controller.searchText.value = value;
                      },
                    ),
                  ),
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
                  return ProductInCard(
                    items: product[index],
                    onTap: () {
                      controller.openProductModal(product[index].id.toString());
                      Get.bottomSheet(
                        StockInModalBottom(items: product[index]),
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
      bottomSheet: ProductInBottom(controller: controller),
    );
  }
}
