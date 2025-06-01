import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/home/supplier/controllers/supplier_controller.dart';
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
    final arguments = Get.arguments;
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
                hintText: 'input-nama-supplier'.tr,
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
              SizedBox(height: 10.h),
              CustomTextFormField(
                title: 'note'.tr,
                hintText: 'input-catatan'.tr,
                controller: pc.catatanC,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    if (arguments != null) {
                      pc.editSupplier(arguments);
                    } else {
                      pc.addSupplier();
                    }
                  },
                  child: Text('save'.tr),
                ),
              ),
              SizedBox(height: 300.h),
              Container(
                width: controller.bannerAd.size.width.toDouble(),
                height: controller.bannerAd.size.height.toDouble(),
                child: AdWidget(ad: controller.bannerAd),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
