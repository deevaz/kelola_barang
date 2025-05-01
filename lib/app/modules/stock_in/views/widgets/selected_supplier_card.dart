import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/stock_in/views/widgets/supplier_in_card.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class SelectedSupplierCard extends StatelessWidget {
  final RxString supplier;
  SelectedSupplierCard({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.SUPPLIER,
          arguments: {'from': 'SelectedSupplierCard'},
        );
      },
      child: MaterialRounded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Ionicons.person_add_outline,
                        color: ColorStyle.dark,
                      ),
                      onPressed: () {},
                    ),
                    Text(
                      'Pilih Pemasok',
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
              if (supplier.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(color: ColorStyle.dark, height: 0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Pemasok yang dipilih',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorStyle.dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SupplierInCard(supplier: supplier.value),
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
