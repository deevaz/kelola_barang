import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/stock_in/stock_in_product/views/widgets/select_product_card.dart';
import 'package:kelola_barang/app/modules/stock_in/stock_in_product/views/widgets/stock_in_modal_bottom.dart';
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
          controller.loadStokDariProduk();
          print(controller.listProducts);
        },
      ),
      appBar: CustomAppBar(title: 'Pilih Barang', lightBg: false),
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
                      Get.bottomSheet(StockInModalBottom(items: product));
                      print('Pilih Barang ${product[index]['id']}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
