import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/modules/history/views/widgets/history_modal_bottom.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class StockOutCard extends StatelessWidget {
  final Map<String, dynamic> item;
  StockOutCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(item);
        Get.bottomSheet(HistoryModalBottom(item: item));
      },
      child: Container(
        margin: EdgeInsets.all(8.r),
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 230.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        DateFormat(
                          'dd MMM yyyy – HH:mm',
                        ).format(DateTime.parse(item['tanggal'] ?? '')),
                        style: TextStyle(color: ColorStyle.grey),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(
                          Ionicons.archive_outline,
                          color: ColorStyle.danger,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'stock-out'.tr,
                          style: TextStyle(
                            color: ColorStyle.danger,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '(${item.length} Barang)'.tr,
                          style: TextStyle(color: ColorStyle.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    ...item['barang']!.map((barang) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            barang['nama'] ?? '-',
                            style: TextStyle(
                              color: ColorStyle.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            '- ${barang['jumlah_stok_keluar'] ?? 0} Barang'.tr,
                            style: TextStyle(
                              color: ColorStyle.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
              Text(
                '- ${item['total_keluar']}',
                style: TextStyle(
                  color: ColorStyle.danger,
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
