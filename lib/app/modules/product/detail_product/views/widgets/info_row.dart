import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.sp, color: ColorStyle.grey),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
