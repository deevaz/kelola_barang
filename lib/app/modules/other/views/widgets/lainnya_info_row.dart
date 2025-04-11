import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class LainnyaInfoRow extends StatelessWidget {
  final String title;
  final String? info;
  final IconData? icon;
  final IconData? suffixIcon;
  final Function()? onTap;

  const LainnyaInfoRow({
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
        Row(
          children: [
            Icon(icon, size: 30.sp),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  info ?? '',
                  style: TextStyle(color: ColorStyle.grey, fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: onTap,
          icon: Icon(suffixIcon, color: ColorStyle.grey),
        ),
      ],
    );
  }
}
