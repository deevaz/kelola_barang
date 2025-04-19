import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class SupplierInCard extends StatelessWidget {
  final String supplier;
  const SupplierInCard({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: ColorStyle.primary,
            child: Icon(Icons.person, color: ColorStyle.white),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                supplier,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorStyle.dark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                supplier,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorStyle.dark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
