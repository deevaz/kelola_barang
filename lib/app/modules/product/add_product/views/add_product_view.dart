import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/shared/controllers/barcode_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_form_tanggal.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';

import '../controllers/add_product_controller.dart';
import 'widgets/custom_text_form_field.dart';
import 'widgets/kategori_barang_dropdown.dart';
import 'widgets/tambah_gambar.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({super.key});

  final barcodeC = Get.put(BarcodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Tambah Barang'),
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
                          inputType: TextInputType.number,
                          title:
                              barcodeC.barcode.isEmpty
                                  ? 'Kode Barang'
                                  : barcodeC.barcode.toString(),
                          controller: controller.kodeBarangC,
                        ),
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
                            barcodeC.scanBarcode();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  title: 'Nama Barang',
                  controller: controller.namaBarangC,
                ),
                CustomTextField(
                  title: 'Stok Awal',
                  controller: controller.stokAwalC,
                  inputType: TextInputType.number,
                ),
                CustomTextField(
                  title: 'Harga Beli',
                  controller: controller.hargaBeliC,
                  inputType: TextInputType.number,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          CustomTextField(
                            title: 'Harga Grosir',
                            inputType: TextInputType.number,
                            controller: controller.hargaGrosirC,
                          ),
                          CustomTextField(
                            inputType: TextInputType.number,
                            title: 'Harga Jual',
                            controller: controller.hargaJualC,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: TambahGambarButton(c: controller),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(child: KategoriBarangDropdown(c: controller)),
                    SizedBox(width: 10.w),
                    Obx(
                      () => CustomFormTanggal(
                        title: controller.selectedDate.value.toString(),
                        width: 155.w,
                        selectedDate: controller.selectedDate.value,
                        onTap: () {
                          controller.pickDate(context);
                        },
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
                          'Simpan',
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
                          'Simpan & Tambah Lagi',
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
