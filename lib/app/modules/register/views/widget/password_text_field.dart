import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/modules/register/controllers/register_controller.dart';

class RPasswordTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType inputType;
  final bool obscureText;
  final Function? visibility;

  final registC = Get.find<RegisterController>();

  RPasswordTextField({
    super.key,
    required this.title,
    this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.visibility,
    this.obscureText = false,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Obx(
        () => TextField(
          obscureText: registC.isPassword.value,
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            prefixIcon:
                prefixIcon != null
                    ? Icon(prefixIcon, color: ColorStyle.dark)
                    : null,
            suffixIcon: InkWell(
              onTap: () {
                registC.showPassword();
              },
              child: Icon(
                registC.isPassword == true
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: ColorStyle.dark,
              ),
            ),
            label: Text(title),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.sp),
              borderSide: BorderSide(
                width: 6,
                style: BorderStyle.solid,
                color: ColorStyle.dark,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
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
