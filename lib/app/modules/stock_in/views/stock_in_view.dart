import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/modules/product/add_product/views/widgets/custom_text_form_field.dart';
import 'package:kelola_barang/app/modules/stock_in/views/widgets/selected_products_card.dart';
import 'package:kelola_barang/app/modules/stock_in/views/widgets/selected_supplier_card.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/custom_form_tanggal.dart';

import '../controllers/stock_in_controller.dart';

class StockInView extends GetView<StockInController> {
  const StockInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'stock-in'.tr, lightBg: false),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              SelectedProductsCard(selectedProduct: controller.stockInData),
              SizedBox(height: 10.h),
              SelectedSupplierCard(supplier: controller.selectedSupplier),
              SizedBox(height: 10.h),
              Obx(
                () => CustomFormTanggal(
                  title:
                      controller.selectedDate.value == null
                          ? 'select-date'.tr
                          : DateFormat(
                            'dd-MM-yyyy HH:mm',
                          ).format(controller.selectedDate.value!),
                  onTap: () {
                    controller.pickDate(context);
                  },
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                title: 'note'.tr,
                controller: controller.catatanC,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    controller.addStockIn();
                  },
                  child: Text('save'.tr, style: TextStyle(fontSize: 16.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
