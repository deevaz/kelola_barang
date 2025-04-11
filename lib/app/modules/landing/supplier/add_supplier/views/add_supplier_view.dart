import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/landing/supplier/controllers/supplier_controller.dart';
import 'package:kelola_barang/app/modules/product/add_product/views/widgets/custom_text_form_field.dart';
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
      appBar: CustomAppBar(title: 'supplier'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
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
              CustomTextField(
                title: 'Nomor Rekening',
                controller: pc.rekeningC,
                inputType: TextInputType.number,
                hintText: 'Masukkan nomor rekening',
                prefixIcon: Ionicons.wallet_outline,
              ),
              CustomTextFormField(title: 'Catatan', controller: pc.catatanC),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    pc.addSupplier();
                  },
                  child: Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
