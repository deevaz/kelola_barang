import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/stock_in/views/widgets/supplier_in_card.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

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
