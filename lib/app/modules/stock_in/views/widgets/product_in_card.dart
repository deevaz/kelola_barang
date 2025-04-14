import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class ProductInCard extends StatelessWidget {
  const ProductInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              'https://cdn.vectorstock.com/i/1000v/48/06/image-preview-icon-picture-placeholder-vector-31284806.jpg',
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
                'Product Name',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorStyle.dark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'RP. 100.000',
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
            '+1',
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
