import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class MasukCard extends StatelessWidget {
  final Map<String, dynamic> item;
  MasukCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
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
                        // 'Selasa, 11 Maret 2025 09.20',
                        DateFormat(
                          'dd MMM yyyy – HH:mm',
                        ).format(DateTime.parse(item['tanggal'] ?? '')),

                        // item?.tanggal ?? '-',
                        style: TextStyle(color: ColorStyle.grey),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(
                          Ionicons.archive_outline,
                          color: ColorStyle.success,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'Stok Masuk',
                          style: TextStyle(color: ColorStyle.success),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          '(${item['barang']?.length ?? 0} Barang)',
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
                            style: TextStyle(color: ColorStyle.grey),
                          ),
                          Text(
                            '- ${barang['jumlah_stok_masuk'] ?? 0} Barang',
                            style: TextStyle(color: ColorStyle.grey),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
              Text(
                '+ ${item['total_masuk']}',
                style: TextStyle(
                  color: ColorStyle.success,
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
