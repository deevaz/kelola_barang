import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../styles/color_style.dart';

class CustomFormTanggal extends StatelessWidget {
  final double? width;
  final Function()? onTap;
  final String title;

  final DateTime? selectedDate;

  const CustomFormTanggal({
    super.key,
    required this.title,
    this.width,
    this.onTap,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    // String date = DateFormat('dd MMMM yyyy').format(selectedDate!);
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      width: width ?? double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(color: ColorStyle.dark),
        color: ColorStyle.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Icon(Ionicons.calendar_outline, color: ColorStyle.dark),
          Expanded(
            child: TextButton(
              onPressed: onTap,
              child: Text(
                // date ??
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorStyle.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
