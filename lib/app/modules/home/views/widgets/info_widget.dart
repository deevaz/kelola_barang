import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class InfoWidget extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle textStyle;

  const InfoWidget({
    super.key,
    required this.title,
    required this.value,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: ColorStyle.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        Text(value, style: textStyle),
      ],
    );
  }
}
