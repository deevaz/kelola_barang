import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/product/add_product/views/widgets/custom_text_form_field.dart';
import 'package:kelola_barang/app/modules/product/models/product_response.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_form_tanggal.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../controllers/edit_product_controller.dart';
import 'widgets/edit_picture_button.dart';
import 'widgets/edit_product_category_dropdown.dart';

class EditProductView extends GetView<EditProductController> {
  EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductResponse item = Get.arguments as ProductResponse;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(item.namaBarang);
        },
      ),
      appBar: CustomAppBar(title: 'edit-item'.tr, lightBg: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        controller: controller.kodeBarangC,
                        title:
                            controller.barcode.isEmpty
                                ? 'item-code'.tr
                                : controller.barcode.toString(),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: MaterialRounded(
                        child: IconButton(
                          icon: Icon(
                            Ionicons.barcode_outline,
                            color: ColorStyle.dark,
                          ),
                          onPressed: () {
                            controller.scanBarcode();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  title: 'product-name'.tr,
                  controller: controller.namaBarangC,
                ),
                CustomTextField(
                  title: 'initial-stock'.tr,
                  controller: controller.stokAwalC,
                  inputType: TextInputType.number,
                ),
                CustomTextField(
                  title: 'buy-price'.tr,
                  controller: controller.hargaBeliC,
                  inputType: TextInputType.number,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          CustomTextField(
                            title: 'selling-price'.tr,
                            inputType: TextInputType.number,
                            controller: controller.hargaJualC,
                          ),
                          SizedBox(height: 10.h),
                          EditProductCategoryD(c: EditProductController.to),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    EditPictureButton(c: controller),
                  ],
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => CustomFormTanggal(
                    title: controller.selectedDate.value.toString(),
                    width: double.infinity,
                    selectedDate: controller.selectedDate.value,
                    onTap: () {
                      controller.pickDate(context);
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  title: 'Deskripsi',
                  controller: controller.deskripsiC,
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final id = item.id.toString();
                          controller.updateProduct(id);
                          print(item.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyle.primary,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'save'.tr,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorStyle.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
