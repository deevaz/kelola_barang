import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/stock_in/models/product_in_model.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../models/stock_in_model.dart';

class StockInController extends GetxController {
  static StockInController get to => Get.find();

  final catatanC = TextEditingController();
  final RxString selectedSupplier = ''.obs;
  final RxInt totalPrice = 0.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxList<ProductInModel> stockInData = <ProductInModel>[].obs;

  final dio = Dio();
  final userId = BaseController.to.userId.value;
  String token = BaseController.to.token.value;

  var apiConstant = ApiConstant();

  void setSelectedDate(DateTime? date) {
    selectedDate.value = date;
  }

  Future<void> postStockIn() async {
    final stockData = StockInModel(
      pemasok: selectedSupplier.value,
      catatan: catatanC.text,
      tanggalMasuk: selectedDate.value?.toIso8601String() ?? '',
      totalHarga: totalPrice.value,
      barang:
          stockInData.map((item) {
            return Barang(
              nama: item.namaBarang,
              harga: item.harga,
              jumlahStokMasuk: item.stokMasuk,
              totalStok: item.stok,
            );
          }).toList(),
    );
    try {
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await dio.post(
        '${apiConstant.BASE_URL}/stockin/$userId',
        data: json.encode(stockData.toJson()),
        options: Options(headers: headers),
      );

      if (response.statusCode == 201) {
        print('Berhasil kirim: ${response.data}');
        Get.snackbar(
          'success'.tr,
          'stock-in-success'.tr,
          backgroundColor: ColorStyle.success,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
        HomeController.to.selectedChart.value = 'in';
        HistoryController.to.getHistory();
      } else {
        print('Gagal: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error kirim stock in: $e');
    }
  }

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2041),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        selectedDate.value = combinedDateTime;
      }
    }
  }
}
