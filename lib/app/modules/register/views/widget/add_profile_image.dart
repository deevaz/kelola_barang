import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../../controllers/register_controller.dart';

class AddProfileImage extends StatelessWidget {
  final bool isCamera;

  const AddProfileImage({super.key, this.isCamera = true});

  @override
  Widget build(BuildContext context) {
    final RegisterController c = Get.find<RegisterController>();
    return Obx(
      () => MaterialRounded(
        child: Container(
          width: 200.w,
          height: 170.h,
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
      ),
    );
  }
}
