// ignore_for_file: must_be_immutable, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/product/models/product_response.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final Function? onPress;
  final VoidCallback? onEdit;
  final ProductResponse item;
  final VoidCallback? onDelete;

  ProductCard({
    Key? key,
    required this.item,
    this.onPress,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  Widget _roundedButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 55,
        height: 55,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.white,
        ),
        child: Icon(icon, color: iconColor),
      ),
    );
  }

  var apiConstant = ApiConstant();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPress != null) {
          onPress!();
        }
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _roundedButton(
                    icon: Icons.edit,
                    iconColor: ColorStyle.primary,
                    onTap: () {
                      if (onEdit != null) {
                        onEdit!();
                      }
                      Slidable.of(context)?.close();
                    },
                  ),
                  SizedBox(width: 10.w),
                  _roundedButton(
                    icon: Icons.delete,
                    iconColor: ColorStyle.danger,
                    onTap: () {
                      if (onDelete != null) {
                        onDelete!();
                      }
                      Slidable.of(context)?.close();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            height: 120.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 130.w,
                            height: 100.h,
                            color: Colors.white,
                          ),
                        ),
                        Image.network(
                          item.gambar.toString(),
                          width: 130.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return SizedBox(width: 130.w, height: 100.h);
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/img_placeholder.png',
                              width: 130.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          item.namaBarang ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${item.totalStok} Stok',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(
                              Ionicons.barcode_outline,
                              color: ColorStyle.grey,
                              size: 16.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              item.kodeBarang ?? 'Tidak ada kode',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: ColorStyle.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '(${item.kategori})',
                        style: TextStyle(
                          color: ColorStyle.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        currencyFormatter.format(item.hargaBeli ?? 0),
                        style: TextStyle(
                          color: ColorStyle.dark,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
