// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/history/models/history_response_model.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

import 'history_modal_bottom.dart';

class HistoryCard extends GetView<HistoryController> {
  final HistoryResponseModel item;
  HistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(item);
        showDialog(
          context: context,
          builder: (_) {
            return HistoryModalBottom(item: item);
          },
        );
      },

      child: Column(
        children: [
          SizedBox(height: 15.h),
          Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    controller.deleteHistory(
                      item.id.toString(),
                      item.tipe ?? '',
                    );
                    print('Delete ${item.tipe} ${item.id}');
                  },
                  backgroundColor: ColorStyle.danger,
                  foregroundColor: ColorStyle.white,
                  icon: Icons.delete,
                  label: 'delete'.tr,
                ),
              ],
            ),
            child: MaterialRounded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 230.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              DateFormat('dd MMM yyyy – HH:mm').format(
                                item.tipe == 'masuk'
                                    ? (item.tanggalMasuk ?? DateTime.now())
                                    : (item.tanggalKeluar ?? DateTime.now()),
                              ),
                              style: TextStyle(color: ColorStyle.grey),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Icon(
                                item.tipe == 'masuk'
                                    ? Ionicons.archive_outline
                                    : Ionicons.log_out_outline,
                                color:
                                    item.tipe == 'masuk'
                                        ? ColorStyle.success
                                        : ColorStyle.danger,
                                size: 20.sp,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                item.tipe == 'masuk'
                                    ? 'stock-in'.tr
                                    : 'stock-out'.tr,
                                style: TextStyle(
                                  color:
                                      item.tipe == 'masuk'
                                          ? ColorStyle.success
                                          : ColorStyle.danger,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                '(${item.barang!.length} ${'product'.tr})',
                                style: TextStyle(color: ColorStyle.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          ...item.barang!.map((barang) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  barang.nama ?? '',
                                  style: TextStyle(
                                    color: ColorStyle.grey,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  item.tipe == 'masuk'
                                      ? '- ${barang.jumlahStokMasuk ?? 0} ${'product'.tr}'
                                      : '- ${barang.jumlahStokKeluar ?? 0} ${'product'.tr}',
                                  style: TextStyle(
                                    color: ColorStyle.grey,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    Text(
                      item.tipe == 'masuk'
                          ? '+ ${item.totalMasuk ?? 0}'
                          : '- ${item.totalKeluar ?? 0}',
                      style: TextStyle(
                        color:
                            item.tipe == 'masuk'
                                ? ColorStyle.success
                                : ColorStyle.danger,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
