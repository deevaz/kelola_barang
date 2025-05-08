import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/home/views/widgets/chart_in_widget.dart';
import 'package:kelola_barang/app/modules/home/views/widgets/chart_out_widget.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';
import '../controllers/home_controller.dart';
import 'widgets/info_card.dart';
import 'widgets/infor_data_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Obx(() {
                      final image = BaseController.to.image.value;
                      if (image.isNotEmpty) {
                        return Image.network(
                          image,
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Icon(
                          Icons.store,
                          size: 40.w,
                          color: ColorStyle.primary,
                        );
                      }
                    }),
                  ),
                  Spacer(),
                  MaterialRounded(
                    child: IconButton(
                      onPressed: () {
                        print('filter');
                        if (controller.selectedRange.value != null) {
                          Get.defaultDialog(
                            title: 'delete-filter'.tr,
                            content: Text('are-you-sure-delete-filter'.tr),
                            confirm: TextButton(
                              onPressed: () {
                                controller.clearFilter();
                                Get.back();
                              },
                              child: Text(
                                'yes'.tr,
                                style: TextStyle(color: ColorStyle.danger),
                              ),
                            ),
                            cancel: TextButton(
                              onPressed: () {
                                Get.back();
                                controller.pickDateRange(context);
                              },
                              child: Text('edit'.tr),
                            ),
                          );
                        } else {
                          controller.pickDateRange(context);
                        }
                      },
                      icon: Icon(Icons.filter_alt_outlined, size: 30.w),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                BaseController.to.name.value,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorStyle.dark,
                ),
              ),
              SizedBox(height: 10.h),
              InfoDataCard(),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoCard(
                    title: 'stock-in'.tr,
                    icon: 'assets/images/img_stok_masuk.png',
                    onTap: () {
                      Get.toNamed(Routes.STOCK_IN);
                      print('Stok Masuk');
                    },
                  ),

                  InfoCard(
                    title: 'stock-out'.tr,
                    icon: 'assets/images/img_stok_keluar.png',
                    onTap: () {
                      Get.toNamed(Routes.STOCK_OUT);
                      print('Stok Keluar');
                    },
                  ),

                  InfoCard(
                    title: 'supplier'.tr,
                    onTap: () => Get.toNamed(Routes.SUPPLIER),
                    icon: 'assets/images/img_supplier.png',
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              MaterialRounded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                            ),
                            dropdownColor: ColorStyle.white,
                            items: [
                              DropdownMenuItem(
                                value: 'in',
                                child: Text('stock-in'.tr),
                              ),
                              DropdownMenuItem(
                                value: 'out',
                                child: Text('stock-out'.tr),
                              ),
                            ],
                            value: controller.selectedChart.value,
                            onChanged: (value) {
                              print('Selected value: $value');
                              controller.selectedChart.value = value.toString();
                              print(
                                'Selected value: ${controller.selectedChart.value}',
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    Obx(() {
                      return controller.selectedChart.value == 'in'
                          ? ChartInWidget()
                          : ChartOutWidget();
                    }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
