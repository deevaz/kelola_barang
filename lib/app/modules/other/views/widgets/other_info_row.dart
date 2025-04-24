import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class OtherInfoRow extends StatelessWidget {
  final String title;
  final String? info;
  final IconData? icon;
  final IconData? suffixIcon;
  final Function()? onTap;

  const OtherInfoRow({
    super.key,
    required this.title,
    this.info,
    required this.icon,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(icon, size: 24.sp),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      info ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: ColorStyle.grey, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: onTap,
          icon: Icon(suffixIcon, color: ColorStyle.grey),
        ),
      ],
    );
  }
}
