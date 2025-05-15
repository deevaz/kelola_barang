import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/modules/history/models/history_response_model.dart';

class HistoryTable extends StatelessWidget {
  final HistoryResponseModel item;
  const HistoryTable({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'product-name'.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'price'.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'total'.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'total-stock'.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ...item.barang!.map<TableRow>((barang) {
          return TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(barang.nama ?? ''),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                  ).format(double.parse((barang.harga as String?) ?? '0')),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  item.tipe == 'masuk'
                      ? (barang.jumlahStokMasuk ?? 0).toString()
                      : (barang.jumlahStokKeluar ?? 0).toString(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: Text('${barang.jumlahStokMasuk}'),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
