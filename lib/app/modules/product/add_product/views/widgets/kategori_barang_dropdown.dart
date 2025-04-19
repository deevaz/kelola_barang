import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/add_product/controllers/add_product_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class KategoriBarangDropdown extends StatelessWidget {
  final String? value;
  const KategoriBarangDropdown({super.key, this.value, required this.c});

  final AddProductController c;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: ColorStyle.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'category'.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            items:
                c.kategori.map((category) {
                  return DropdownMenuItem<String>(
                    value: category['name'],
                    child: Text(
                      category['name'],
                      style: TextStyle(color: ColorStyle.dark, fontSize: 14.sp),
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              c.selectedCategory.value = value!;
            },
          ),
        ),
      ),
    );
  }
}
