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
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            children: [
              CustomTextField(
                title: 'supplier-name'.tr,
                controller: pc.namaPemasokC,
                hintText: 'Masukkan nama pemasok',
                prefixIcon: Ionicons.person_outline,
              ),

              Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      title: 'phone-number'.tr,
                      controller: pc.teleponC,
                      inputType: TextInputType.phone,
                      hintText: 'input-telepon'.tr,
                      prefixIcon: Ionicons.call_outline,
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
                          onPressed: () {
                            print('pilih nomor telepon');
                            // Get.to(ContactListView());
                            controller.selectContact();
                            print(
                              'Selected Phone Number: ${controller.selectedPhoneNumber.value}',
                            );
                          },
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
              CustomTextField(
                title: 'rekening'.tr,
                controller: pc.rekeningC,
                inputType: TextInputType.number,
                hintText: 'input-rekening'.tr,
                prefixIcon: Ionicons.wallet_outline,
              ),
              CustomTextFormField(
                title: 'note'.tr,
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
