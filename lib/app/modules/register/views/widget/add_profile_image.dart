import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

import '../../controllers/register_controller.dart';

class AddProfileImage extends StatelessWidget {
  final bool isCamera;

  const AddProfileImage({super.key, this.isCamera = true});

  @override
  Widget build(BuildContext context) {
    final RegisterController c = Get.find<RegisterController>();
    return Obx(
      () => Container(
        width: 170.w,
        height: 135.h,
        decoration: BoxDecoration(
          image:
              c.selectedImage.value != null
                  ? DecorationImage(
                    image: FileImage(File(c.selectedImage.value!.path)),
                    fit: BoxFit.cover,
                  )
                  : null,
          border: Border.all(color: ColorStyle.dark),
          color: ColorStyle.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Ionicons.camera_outline,
                size: 40.sp,
                color:
                    c.selectedImage.value != null
                        ? Colors.transparent
                        : ColorStyle.dark,
              ),
              onPressed: () {
                Get.defaultDialog(
                  title: 'select-image'.tr,
                  titleStyle: TextStyle(
                    fontSize: 20.sp,
                    color: ColorStyle.dark,
                    fontWeight: FontWeight.bold,
                  ),
                  content: Column(
                    children: [
                      ListTile(
                        leading: Icon(Ionicons.camera_outline),
                        title: Text('camera'.tr),
                        onTap: () {
                          c.selectedImage.value = null;
                          c.pickImage(true);
                          Get.back();
                        },
                      ),
                      ListTile(
                        leading: Icon(Ionicons.image_outline),
                        title: Text('gallery'.tr),
                        onTap: () {
                          c.selectedImage.value = null;
                          c.pickImage(false);
                          Get.back();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Text(
              'add-picture'.tr,
              style: TextStyle(
                fontSize: 12.sp,
                color:
                    c.selectedImage.value != null
                        ? Colors.transparent
                        : ColorStyle.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
