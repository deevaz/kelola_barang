import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../../controllers/other_controller.dart';

class DelAccountTextfield extends StatelessWidget {
  const DelAccountTextfield({super.key, required this.c});

  final OtherController c;

  @override
  Widget build(BuildContext context) {
    return MaterialRounded(
      child: Obx(
        () => TextField(
          obscureText: c.hide.value ? true : false,
          controller: c.passwordC,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock, color: ColorStyle.dark),
            suffixIcon: InkWell(
              onTap: () {
                c.showPassword();
              },
              child: Icon(
                c.hide.value ? Icons.visibility_off : Icons.visibility,
                color: ColorStyle.dark,
              ),
            ),

            hintText: 'password'.tr,
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
