// ignore_for_file: must_be_immutable, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final Function? onPress;
  final VoidCallback? onEdit;
  final Map<String, dynamic> item;
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
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    child:
                        item['gambar'] != null
                            ? Image.network(
                              'http://192.168.0.101:8000/storage/${item['gambar']}',
                              width: 130.w,
                              fit: BoxFit.cover,
                            )
                            : Image.asset(
                              'assets/images/img_placeholder.png',
                              width: 130.w,
                              fit: BoxFit.cover,
                            ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          item['nama_barang'] ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${item['stok_awal']} Stok',
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
                              item['kode_barang'] ?? 'Tidak ada kode',
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
                        '(${item['kategori']})',
                        style: TextStyle(
                          color: ColorStyle.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        currencyFormatter.format(item['harga_beli'] ?? 0),
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
