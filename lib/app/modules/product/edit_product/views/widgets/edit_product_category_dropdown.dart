import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:kelola_barang/app/modules/product/edit_product/controllers/edit_product_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class EditProductCategoryD extends StatelessWidget {
  final String? value;
  const EditProductCategoryD({super.key, this.value, required this.c});

  final EditProductController c;

  @override
  Widget build(BuildContext context) {
    return MaterialRounded(
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'category'.tr,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide.none,
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
    );
  }
}
