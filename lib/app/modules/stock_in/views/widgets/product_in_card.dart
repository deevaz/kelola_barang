import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kelola_barang/app/shared/styles/color_style.dart';

class ProductInCard extends StatelessWidget {
  final String namaBarang;
  final String gambar;
  final int harga;
  final int stokMasuk;

  ProductInCard({
    required this.namaBarang,
    required this.gambar,
    required this.harga,
    required this.stokMasuk,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              gambar,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50.w,
                  height: 50.h,
                  color: ColorStyle.grey,
                  child: Icon(
                    Icons.broken_image,
                    size: 50.sp,
                    color: ColorStyle.light,
                  ),
                );
              },
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                namaBarang,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorStyle.dark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'Rp ${harga.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorStyle.dark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '+$stokMasuk',
            style: TextStyle(
              fontSize: 24.sp,
              color: ColorStyle.success,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
