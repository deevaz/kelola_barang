import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/stock_in/views/widgets/product_in_card.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';

import 'package:kelola_barang/app/shared/styles/color_style.dart';

class SelectedProductsCard extends StatelessWidget {
  const SelectedProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    bool barang = false;
    return InkWell(
      onTap: () {
        // Get.toNamed('/stok_masuk_barang');
        Get.toNamed(Routes.STOCK_IN_PRODUCT);
        print('Selected Products Card tapped');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorStyle.dark),
          color: ColorStyle.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  icon: Icon(Ionicons.chevron_forward, color: ColorStyle.dark),
                  onPressed: () {},
                ),
              ],
            ),
            // Obx(() {
            ...[
              if (barang == true)
                Column(
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
                          // items: barang[index]
                        );
                      },
                      itemCount: 2,
                      //  barang.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                )
              else
                SizedBox.shrink(),
            ],
            // }),
          ],
        ),
      ),
    );
  }
}
