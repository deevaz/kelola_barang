import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

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
    final items = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyle.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Detail Barang',
          style: TextStyle(
            color: ColorStyle.dark,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'http://192.168.0.101:8000/storage/${items['gambar']}',
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 510.h,
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
                        items['nama_barang'] ?? '',
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
                            items['kode_barang'] ?? '',
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
                    '${items['total_stok']} STOK',
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
                title: 'Harga Beli',
                value: currencyFormatter.format(items['harga_beli'] ?? 0),
              ),
              InfoRow(
                title: 'Harga Jual',
                value: currencyFormatter.format(items['harga_jual'] ?? 0),
              ),
              InfoRow(title: 'Kategori', value: '${items['kategori']}'),
              InfoRow(
                title: 'Kadaluarsa',
                value:
                // items.kadaluarsa!.toString(),
                DateFormat(
                  'dd MMM yyyy – HH:mm',
                ).format(DateTime.parse(items['kadaluarsa'])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(
                      'Deskripsi',
                      style: TextStyle(fontSize: 18.sp, color: ColorStyle.grey),
                    ),
                    const Spacer(),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: 'Deskripsi',
                            titleStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            content: Container(
                              padding: EdgeInsets.all(20.w),
                              child: Text(
                                items['deskripsi'] ?? '',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          items['deskripsi'] ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                  'Ubah',
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
