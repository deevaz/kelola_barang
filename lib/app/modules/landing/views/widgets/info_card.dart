import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final RxString? value;
  final String icon;
  final void Function()? onTap;

  const InfoCard({
    super.key,
    required this.title,
    this.value,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MaterialRounded(
        child: SizedBox(
          width: 115.sp,
          height: 129.sp,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(icon, width: 50.sp, height: 50.sp),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 75.w,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorStyle.dark,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
