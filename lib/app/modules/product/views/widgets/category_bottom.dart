import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/controllers/product_controller.dart';

class CategoryBottomSheet extends StatelessWidget {
  const CategoryBottomSheet({super.key, required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('all-category'.tr),
              onTap: () {
                controller.filterByCategory('');
                Get.back();
              },
            ),
            ...controller.categories.map((kategori) {
              return ListTile(
                title: Text(kategori['name']),
                onTap: () {
                  controller.filterByCategory(kategori['name']);
                  print(kategori['name']);
                  Get.back();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
