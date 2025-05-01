import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/stock_in/models/product_in_model.dart';
import 'package:kelola_barang/app/modules/stock_in/views/widgets/product_in_card.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';

import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class SelectedProductsCard extends StatelessWidget {
  final RxList<ProductInModel> selectedProduct;

  const SelectedProductsCard({super.key, required this.selectedProduct});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.STOCK_IN_PRODUCT);
        print('Selected Products Card tapped');
      },
      child: MaterialRounded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    SizedBox(width: 10.w),
                    Icon(Ionicons.archive_outline, color: ColorStyle.dark),
                    SizedBox(width: 10.w),
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
                  icon: Icon(Ionicons.chevron_forward, color: ColorStyle.dark),
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
                        return ProductInCard(
                          namaBarang: selectedProduct[index].namaBarang,
                          gambar: selectedProduct[index].gambar,
                          harga: selectedProduct[index].harga,
                          stokMasuk: selectedProduct[index].stokMasuk,
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
    );
  }
}
