import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../controllers/other_controller.dart';

class DeleteAccountView extends GetView {
  DeleteAccountView({super.key});
  final c = Get.put(OtherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'delete-account'.tr, lightBg: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DeletePasswordText(c: c),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: EvelatedButtonStyle.danger,
                onPressed: () {
                  c.deleteAccount();
                },
                child: Text('delete-password'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeletePasswordText extends StatelessWidget {
  const DeletePasswordText({super.key, required this.c});

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
