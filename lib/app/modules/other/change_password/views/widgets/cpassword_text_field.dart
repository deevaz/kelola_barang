import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:kelola_barang/app/modules/other/change_password/controllers/change_password_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class CPasswordTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType inputType;
  final bool obscureText;
  final Function? visibility;

  final loginC = Get.find<ChangePasswordController>();

  CPasswordTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.visibility,
    this.obscureText = false,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialRounded(
      child: Obx(
        () => TextField(
          obscureText: loginC.isPassword.value,
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            prefixIcon:
                prefixIcon != null
                    ? Icon(prefixIcon, color: ColorStyle.dark)
                    : null,
            suffixIcon:
                suffixIcon != null
                    ? InkWell(
                      onTap: () {
                        loginC.showPassword();
                      },
                      child: Icon(
                        loginC.isPassword == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: ColorStyle.dark,
                      ),
                    )
                    : null,

            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.never,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.sp),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(16.sp),
            fillColor: ColorStyle.white,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: ColorStyle.dark.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
