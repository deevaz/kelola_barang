import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/product/add_product/controllers/add_product_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class AddPictureButton extends StatelessWidget {
  final AddProductController c;

  const AddPictureButton({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 155.w,
        height: 100.h,
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
                        ? ColorStyle.grey
                        : ColorStyle.dark,
              ),
              onPressed: () {
                Get.defaultDialog(
                  title: 'Pilih Gambar',
                  titleStyle: TextStyle(
                    fontSize: 20.sp,
                    color: ColorStyle.dark,
                    fontWeight: FontWeight.bold,
                  ),
                  content: Column(
                    children: [
                      ListTile(
                        leading: Icon(Ionicons.camera_outline),
                        title: Text('Kamera'),
                        onTap: () {
                          c.selectedImage.value = null;
                          c.pickImage(true);
                          Get.back();
                        },
                      ),
                      ListTile(
                        leading: Icon(Ionicons.image_outline),
                        title: Text('Galeri'),
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
                color: ColorStyle.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
