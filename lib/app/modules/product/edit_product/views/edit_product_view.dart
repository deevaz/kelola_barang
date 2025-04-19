import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/product/add_product/controllers/add_product_controller.dart';
import 'package:kelola_barang/app/modules/product/add_product/views/widgets/custom_text_form_field.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';

import '../../add_product/views/widgets/kategori_barang_dropdown.dart';
import '../controllers/edit_product_controller.dart';
import 'widgets/edit_gambar_button.dart';

class EditProductView extends GetView<EditProductController> {
  EditProductView({super.key});

  final item = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(item['id']);
        },
      ),
      appBar: CustomAppBar(title: 'edit-item'.tr),
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
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
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
                          // CustomTextField(
                          //   inputType: TextInputType.number,
                          //   title: 'Harga Grosir',
                          //   controller: controller.hargaGrosirC,
                          // ),
                          CustomTextField(
                            title: 'selling-price'.tr,
                            inputType: TextInputType.number,
                            controller: controller.hargaJualC,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: EditGambarButton(c: controller),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      // ! BELUM SESUAI
                      child: KategoriBarangDropdown(c: AddProductController.to),
                    ),
                    SizedBox(width: 10.w),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Container(
                        width: 155.w,
                        height: 50.h,
                        decoration: BoxDecoration(
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
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Ionicons.calendar_outline,
                                color: ColorStyle.dark,
                              ),
                              onPressed: () {
                                controller.pickDate(context);
                              },
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  controller.pickDate(context);
                                },
                                child: Text(
                                  controller.selectedDate.value.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: ColorStyle.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                          final id = item['id'].toString();
                          controller.updateProduct(id);
                          print(item['id']);
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
