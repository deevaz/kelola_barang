import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';

import '../controllers/other_controller.dart';
import 'widgets/del_account_textfield.dart';

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
            DelAccountTextfield(c: c),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: EvelatedButtonStyle.danger,
                onPressed: () {
                  c.deleteAccount();
                },
                child: Text('delete-account'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
