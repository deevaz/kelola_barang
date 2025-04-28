import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

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
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 2,
        child: TextFormField(
          controller: controller,
          maxLines: 7,
          decoration: InputDecoration(
            label: Text(title),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: hintText,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(15.r)),
            //   // borderSide: BorderSide(width: 1, color: ColorStyle.primary),
            // ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),

              borderSide: BorderSide(
                width: 6,
                style: BorderStyle.solid,
                color: ColorStyle.light,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(15.r),
            fillColor: ColorStyle.white,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: ColorStyle.dark.withOpacity(0.5),
            ),
          ),
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorStyle.dark.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
