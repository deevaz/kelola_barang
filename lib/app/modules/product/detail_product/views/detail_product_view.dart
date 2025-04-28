import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';

import '../../models/product_response.dart';
import '../controllers/detail_product_controller.dart';
import 'widgets/info_row.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({super.key});

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final ProductResponse items = Get.arguments as ProductResponse;
    return Scaffold(
      appBar: CustomAppBar(title: 'product-detail'.tr, lightBg: false),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  items.gambar!,
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/img_placeholder.png',
                      width: 200.w,
                      height: 200.h,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 530.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorStyle.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items.namaBarang!,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Ionicons.barcode_outline,
                            color: ColorStyle.grey,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            items.kodeBarang!,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorStyle.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '${items.totalStok} STOK',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorStyle.dark,
                    ),
                  ),
                ],
              ),
              const Divider(),
              InfoRow(
                title: 'buy-price'.tr,
                value: currencyFormatter.format(items.hargaBeli),
              ),
              InfoRow(
                title: 'sell-price'.tr,
                value: currencyFormatter.format(items.hargaJual),
              ),
              InfoRow(title: 'Kategori', value: '${items.kategori}'),
              InfoRow(
                title: 'expired'.tr,
                value: DateFormat(
                  'dd MMM yyyy – HH:mm',
                ).format(items.kadaluarsa!),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'deskripsi'.tr,

                      style: TextStyle(fontSize: 18.sp, color: ColorStyle.grey),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'deskripsi'.tr,
                          titleStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          titlePadding: EdgeInsets.only(
                            top: 20.h,
                            left: 20.w,
                            right: 20.w,
                          ),
                          content: Column(
                            children: [
                              const Divider(),
                              SizedBox(height: 10.h),
                              Text(
                                items.deskripsi!,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(items.deskripsi!).split(' ').first}..',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Ionicons.chevron_forward_outline,
                            size: 20.sp,
                            color: ColorStyle.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyle.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  minimumSize: Size(double.infinity, 50.h),
                ),
                onPressed: () {
                  Get.toNamed(Routes.EDIT_PRODUCT, arguments: items);
                },
                child: Text(
                  'change'.tr,
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
