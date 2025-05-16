import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/stock_in/controllers/stock_in_controller.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';
import 'package:kelola_barang/app/shared/widgets/search_widget.dart';

import '../controllers/supplier_controller.dart';

class SupplierView extends GetView<SupplierController> {
  const SupplierView({super.key});
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final data = controller.supplier;
    final stockC = Get.put(StockInController());
    return Scaffold(
      appBar: CustomAppBar(title: 'supplier'.tr, lightBg: false),
      body: Column(
        children: [
          SearchWidget(
            onChanged: (value) {
              controller.filterSupplier(value);
              controller.searchText.value = value;
            },
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final supplier = controller.supplier[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 5.h,
                    ),
                    child: InkWell(
                      onTap: () {
                        if (arguments?['from'] == 'SelectedSupplierCard') {
                          print('Selected Supplier: ${supplier.namaSupplier}');
                          stockC.selectedSupplier.value =
                              supplier.namaSupplier.toString();

                          Get.back();
                        } else if (arguments == null) {
                          print('Selected Supplier: ${supplier.namaSupplier}');
                          Get.bottomSheet(
                            Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'supplier-name: ${supplier.namaSupplier}',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'supplier-name: ${supplier.namaSupplier}',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  Text(
                                    'phone-number'.tr + ': ${supplier.noTelp}',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  Text(
                                    'bank-account: ${supplier.noRekening}',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  Text(
                                    'note'.tr + ': ${supplier.catatan}',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  SizedBox(height: 20.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      style: EvelatedButtonStyle.rounded15,
                                      child: Text(
                                        'close'.tr,
                                        style: TextStyle(
                                          color: ColorStyle.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                controller.deleteSupplier(
                                  supplier.id.toString(),
                                );
                                controller.getAllSuppliers();
                              },
                              backgroundColor: ColorStyle.danger,
                              foregroundColor: ColorStyle.white,
                              icon: Icons.delete,
                              label: 'delete'.tr,
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Get.toNamed(
                                  Routes.ADD_SUPPLIER,
                                  arguments: supplier.id.toString(),
                                );
                                controller.namaPemasokC.text =
                                    supplier.namaSupplier.toString();
                                controller.teleponC.text =
                                    supplier.noTelp.toString();
                                controller.rekeningC.text =
                                    supplier.noRekening.toString();
                                controller.catatanC.text =
                                    supplier.catatan.toString();
                              },
                              backgroundColor: ColorStyle.warning,
                              foregroundColor: ColorStyle.white,
                              icon: Icons.edit,
                              label: 'edit'.tr,
                            ),
                          ],
                        ),
                        child: MaterialRounded(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: ColorStyle.grey,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
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
                                    supplier.namaSupplier.toString(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    supplier.noTelp.toString(),
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
      floatingActionButton:
          (arguments?['from'] == 'SelectedSupplierCard')
              ? null
              : FloatingActionButton(
                backgroundColor: ColorStyle.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                onPressed: () {
                  Get.toNamed(Routes.ADD_SUPPLIER);
                  controller.getAllSuppliers();
                  print('Tambah Pemasok');
                  print(controller.supplier.length);
                },
                child: Icon(Icons.add, color: ColorStyle.white),
              ),
    );
  }
}
