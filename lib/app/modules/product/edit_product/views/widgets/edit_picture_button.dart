import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../../controllers/edit_product_controller.dart';

class EditPictureButton extends StatelessWidget {
  final EditProductController c;
  final bool isCamera;

  const EditPictureButton({super.key, required this.c, this.isCamera = true});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SizedBox(height: 10.h),
          MaterialRounded(
            child: Container(
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

                borderRadius: BorderRadius.circular(10.r),
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
                              ? ColorStyle.white.withOpacity(0.8)
                              : ColorStyle.dark,
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'edit-picture'.tr,
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
                    'edit-picture'.tr,
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
        ],
      ),
    );
  }
}
