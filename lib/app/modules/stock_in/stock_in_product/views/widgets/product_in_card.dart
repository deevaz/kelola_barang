import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/product/models/product_response.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/stock_in_product_controller.dart';

class ProductInCard extends StatelessWidget {
  final ProductResponse items;

  final Function()? onTap;
  const ProductInCard({super.key, required this.items, this.onTap});

  @override
  Widget build(BuildContext context) {
    final stockInP = StockInProductController.to;
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MaterialRounded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 130.w,
                          height: 120.h,
                          color: Colors.white,
                        ),
                      ),

                      Image.network(
                        items.gambar ??
                            'https://kelolabarang.com/assets/images/img_placeholder.png',
                        width: 130.w,
                        height: 120.h,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return SizedBox(width: 130.w, height: 100.h);
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/img_placeholder.png',
                            width: 130.w,
                            height: 120.h,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        items.namaBarang ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp ${items.hargaBeli}',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(
                            Ionicons.barcode_outline,
                            color: ColorStyle.grey,
                            size: 16.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            items.kodeBarang ?? '',
                            style: TextStyle(color: ColorStyle.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40.w),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        items.stok.toString(),
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() {
                        final productIn = stockInP.selectedProducts
                            .firstWhereOrNull(
                              (p) => p.id == items.id.toString(),
                            );

                        return Text(
                          '+ ${productIn?.jumlahstokMasuk ?? 0}',
                          style: TextStyle(
                            color: ColorStyle.success,
                            fontSize: 22.sp,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
