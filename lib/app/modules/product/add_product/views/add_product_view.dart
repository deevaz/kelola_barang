import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/barcode_scanner/controllers/barcode_scanner_controller.dart';

import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_form_tanggal.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import '../controllers/add_product_controller.dart';
import 'widgets/custom_text_form_field.dart';
import 'widgets/product_category_dropdown.dart';
import 'widgets/add_picture.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({super.key});

  final barcodeC = Get.put(BarcodeScannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'add-item'.tr, lightBg: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Obx(
                        () => CustomTextField(
                          title:
                              controller.barcode.isEmpty
                                  ? 'item-code'.tr
                                  : controller.barcode.toString(),
                          controller: controller.kodeBarangC,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: MaterialRounded(
                        child: SizedBox(
                          height: 50.h,
                          width: 50.w,
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
                    ),
                  ],
                ),
                CustomTextField(
                  title: 'product-name'.tr,
                  controller: controller.namaBarangC,
                ),
                CustomTextField(
                  title: 'initial-stock'.tr,
                  controller: controller.stokC,
                  inputType: TextInputType.number,
                ),
                CustomTextField(
                  title: 'buy-price'.tr,
                  controller: controller.hargaBeliC,
                  inputType: TextInputType.number,
                  isPrice: true,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          CustomTextField(
                            inputType: TextInputType.number,
                            title: 'selling-price'.tr,
                            isPrice: true,
                            controller: controller.hargaJualC,
                          ),
                          SizedBox(height: 10.h),
                          ProductCategoryDropdown(c: controller),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    AddPictureButton(c: controller),
                  ],
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => CustomFormTanggal(
                    title: DateFormat(
                      'dd MMMM yyyy, HH:mm',
                    ).format(controller.selectedDate.value),
                    width: double.infinity,
                    selectedDate: controller.selectedDate.value,
                    onTap: () {
                      controller.pickDate(context);
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  title: 'deskripsi'.tr,
                  controller: controller.deskripsiC,
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.addProduct(false);
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
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.addProduct(true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyle.primary,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'save-create'.tr,
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
