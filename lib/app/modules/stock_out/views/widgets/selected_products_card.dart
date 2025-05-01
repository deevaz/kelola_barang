import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/stock_out/models/product_out_model.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';

import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import 'product_out_card.dart';

class SelectedProductsCard extends StatelessWidget {
  final RxList<ProductOutModel> selectedProduct;

  const SelectedProductsCard({super.key, required this.selectedProduct});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.STOCK_OUT_PRODUCT);
        print('Selected Products Card tapped');
      },
      child: MaterialRounded(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Ionicons.archive_outline,
                          color: ColorStyle.dark,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        'select-product'.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorStyle.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Ionicons.chevron_forward,
                      color: ColorStyle.dark,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Obx(() {
                if (selectedProduct.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(color: ColorStyle.dark, height: 0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Barang yang dipilih',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorStyle.dark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return ProductOutCard(
                            namaBarang: selectedProduct[index].namaBarang,
                            gambar: selectedProduct[index].gambar,
                            harga: selectedProduct[index].harga,
                            stokKeluar: selectedProduct[index].stokKeluar,
                          );
                        },
                        itemCount: selectedProduct.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
