import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType inputType;
  final bool isPrice;

  const CustomTextField({
    super.key,
    required this.title,
    this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.isPrice = false,
    this.suffixIcon,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 2,
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          inputFormatters:
              isPrice
                  ? [
                    MoneyInputFormatter(
                      thousandSeparator: ThousandSeparator.Period,
                      mantissaLength: 0,
                    ),
                  ]
                  : null,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon:
                prefixIcon != null
                    ? Icon(prefixIcon, color: ColorStyle.dark)
                    : null,
            suffixIcon:
                suffixIcon != null
                    ? Icon(suffixIcon, color: ColorStyle.dark)
                    : null,
            label: Text(title),
            labelStyle: TextStyle(fontSize: 14.sp, color: ColorStyle.dark),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.sp),
              borderSide: BorderSide.none,
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16.sp),
            fillColor: ColorStyle.white,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: ColorStyle.dark.withOpacity(0.5),
            ),
          ),
          style: TextStyle(fontSize: 14.sp, color: ColorStyle.dark),
        ),
      ),
    );
  }
}
