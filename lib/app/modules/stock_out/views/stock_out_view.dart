import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/add_product/views/widgets/custom_text_form_field.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_form_tanggal.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';

import '../controllers/stock_out_controller.dart';
import 'widgets/selected_products_card.dart';

class StockOutView extends GetView<StockOutController> {
  const StockOutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'stock-out'.tr, lightBg: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SelectedProductsCard(selectedProduct: controller.stockOutData),
              CustomTextField(
                title: 'buyer'.tr,
                controller: controller.buyerC,
                hintText: 'buyer'.tr,
                prefixIcon: Icons.person_2_outlined,
              ),
              SizedBox(height: 10.h),
              Obx(
                () => CustomFormTanggal(
                  title:
                      controller.selectedDate.value == null
                          ? 'select-date'.tr
                          : controller.selectedDate.value.toString(),
                  onTap: () {
                    controller.pickDate(context);
                  },
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                title: 'note'.tr,
                controller: controller.noteC,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    controller.postStockOut();
                  },
                  child: Text('Simpan', style: TextStyle(fontSize: 16.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
