import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/landing/supplier/controllers/supplier_controller.dart';
import 'package:kelola_barang/app/modules/product/add_product/views/widgets/custom_text_form_field.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';

import '../controllers/add_supplier_controller.dart';

class AddSupplierView extends GetView<AddSupplierController> {
  const AddSupplierView({super.key});
  @override
  Widget build(BuildContext context) {
    final pc = Get.put(SupplierController());
    return Scaffold(
      appBar: CustomAppBar(title: 'supplier'.tr, lightBg: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              CustomTextField(
                title: 'Nama Pemasok',
                controller: pc.namaPemasokC,
                hintText: 'Masukkan nama pemasok',
                prefixIcon: Ionicons.person_outline,
              ),
              CustomTextField(
                title: 'Nomor Telepon',
                controller: pc.teleponC,
                inputType: TextInputType.phone,
                hintText: 'Masukkan nomor telepon',
                prefixIcon: Ionicons.call_outline,
              ),
              Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      title: 'Nomor Rekening',
                      controller: pc.rekeningC,
                      inputType: TextInputType.number,
                      hintText: 'Masukkan nomor rekening',
                      prefixIcon: Ionicons.wallet_outline,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 2,
                      color: ColorStyle.white,
                      child: SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.contact_phone_outlined,
                            color: ColorStyle.dark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                title: 'Catatan',
                hintText: 'Masukkan catatan',
                controller: pc.catatanC,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    pc.addSupplier();
                  },
                  child: Text('save'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
