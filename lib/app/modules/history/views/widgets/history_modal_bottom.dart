import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/modules/history/views/widgets/history_table.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart'
    show ColorStyle;

class HistoryModalBottom extends StatelessWidget {
  final Map<String, dynamic> item;
  HistoryModalBottom({super.key, required this.item});

  String formatTanggal(String input) {
    DateTime dateTime = DateTime.parse(input);
    String tanggal = DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
    String jam = DateFormat('HH.mm').format(dateTime);
    return '$tanggal - $jam';
  }

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorStyle.white),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 30.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'history-detail'.tr,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  formatTanggal(item['tanggal']),
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
            const Divider(color: Colors.grey, thickness: 1),
            SizedBox(height: 5.h),
            item['tipe'] == 'masuk'
                ? Text(
                  'supplier'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorStyle.grey,
                  ),
                )
                : Text(
                  'buyer'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorStyle.grey,
                  ),
                ),

            Text(
              item['tipe'] == 'masuk'
                  ? item['pemasok'] ?? '-'
                  : item['pembeli'] ?? '-',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorStyle.dark,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'note'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorStyle.grey,
              ),
            ),
            Text(
              item['catatan'] ?? '-',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorStyle.dark,
              ),
            ),

            SizedBox(height: 10.h),
            Text(
              'list-product'.tr,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            HistoryTable(item: item),
            SizedBox(height: 10.h),
            Text(
              'total-price'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorStyle.grey,
              ),
            ),
            Text(
              currencyFormatter.format(
                double.tryParse(item['total_harga']?.toString() ?? '0') ?? 0,
              ),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorStyle.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
