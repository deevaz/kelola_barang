import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/stock_out/stock_out_product/controllers/stock_out_product_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class SelectProductCard extends StatelessWidget {
  final dynamic items;
  final Function()? onTap;
  const SelectProductCard({super.key, this.items, this.onTap});

  @override
  Widget build(BuildContext context) {
    final stockInP = StockOutProductController.to;
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    items['gambar'] ?? '',
                    width: 130.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 130.w,
                        height: 130.h,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.broken_image,
                          size: 50.sp,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        items['nama_barang'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp ${items['harga_jual']}',
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
                            items['kode_barang'] ?? '',
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
                        items['total_stok'].toString(),
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() {
                        final stokMasuk = stockInP.getStokKeluar(
                          items['id']!.toString(),
                        );
                        return Text(
                          '- ${stokMasuk.toString()}',
                          style: TextStyle(
                            color: ColorStyle.danger,
                            fontSize: 22.sp,
                          ),
                        );
                      }),
                      // }),
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
