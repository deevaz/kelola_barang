import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String? hintText;

  final TextEditingController? controller;
  const CustomTextFormField({
    super.key,
    required this.title,
    this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialRounded(
      child: TextFormField(
        controller: controller,
        maxLines: 6,
        decoration: InputDecoration(
          label: Text(title),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding: EdgeInsets.all(15.r),
          fillColor: ColorStyle.white,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: ColorStyle.dark.withOpacity(0.5),
          ),
        ),
        style: TextStyle(fontSize: 14.sp, color: ColorStyle.dark),
      ),
    );
  }
}
