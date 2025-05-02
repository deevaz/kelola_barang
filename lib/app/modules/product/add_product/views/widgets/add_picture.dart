import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/product/add_product/controllers/add_product_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class AddPictureButton extends StatelessWidget {
  final AddProductController c;

  const AddPictureButton({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10.h),
        width: 155.w,
        height: 120.h,
        decoration: BoxDecoration(
          image:
              c.selectedImage.value != null
                  ? DecorationImage(
                    image: FileImage(File(c.selectedImage.value!.path)),
                    fit: BoxFit.cover,
                  )
                  : null,
        ),
        child: MaterialRounded(
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
      ),
    );
  }
}
