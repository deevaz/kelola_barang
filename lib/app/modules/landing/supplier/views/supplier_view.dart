import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/search_widget.dart';

import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({super.key});
  @override
  Widget build(BuildContext context) {
    final pemasok = controller.pemasok;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorStyle.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        onPressed: () {
          Get.toNamed(Routes.ADD_SUPPLIER);
          controller.getAllSuppliers();
          print('Tambah Pemasok');
          print(controller.pemasok.length);
        },
        child: Icon(Icons.add, color: ColorStyle.white),
      ),
      appBar: CustomAppBar(title: 'supplier'.tr),
      body: Column(
        children: [
          SearchWidget(),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: pemasok.length,
                itemBuilder: (context, index) {
                  final supplier = controller.pemasok[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    child: InkWell(
                      onTap: () {
                        // StokMasukController.to.addItem(pemasok[index]);
                        // Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorStyle.grey),
                          borderRadius: BorderRadius.circular(15.r),
                          color: ColorStyle.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: CircleAvatar(
                                radius: 30.r,
                                backgroundColor: ColorStyle.grey,
                                child: Icon(
                                  Icons.person,
                                  color: ColorStyle.white,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  supplier['nama_supplier'],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  supplier['no_telp'].toString(),
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
