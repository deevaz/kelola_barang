import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/landing/controllers/landing_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../models/product_out_model.dart';
import '../models/stock_out_model.dart';

class StockOutController extends GetxController {
  static StockOutController get to => Get.find();
  final noteC = TextEditingController();
  final buyerC = TextEditingController();
  final RxString selectedBuyer = ''.obs;
  final RxInt totalPrice = 0.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxList<ProductOutModel> stockOutData = <ProductOutModel>[].obs;

  final dio = Dio();
  final userId = HomeController.to.userId.value;

  var apiConstant = ApiConstant();

  void setSelectedDate(DateTime? date) {
    selectedDate.value = date;
  }

  Future<void> postStockOut() async {
    final stockData = StockOutModel(
      pembeli: buyerC.text,
      catatan: noteC.text,
      tanggalKeluar: selectedDate.value?.toIso8601String() ?? '',
      totalHarga: totalPrice.value,
      barang:
          stockOutData.map((item) {
            return Barang(
              nama: item.namaBarang,
              harga: item.harga,
              jumlahStokKeluar: item.stokKeluar,
              totalStok: item.stok,
            );
          }).toList(),
    );
    try {
      var token = await HomeController.to.token.value;
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await dio.post(
        '${apiConstant.BASE_URL}/stockout/$userId',
        data: json.encode(stockData.toJson()),
        options: Options(
          headers: headers,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 201) {
        print('Berhasil kirim: ${response.data}');
        Get.snackbar(
          'Berhasil',
          'Stock Keluar berhasil disimpan',
          backgroundColor: ColorStyle.success,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
        LandingController.to.selectedChart.value = 'out';
        HistoryController.to.getHistory();
      } else {
        print('Gagal kirim stock out: ${response.statusCode}');
        print('Detail error: ${response.data}');
      }
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode}');
      print('DioError data: ${e.response?.data}');
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

  @override
  void onInit() {
    super.onInit();
  }
}
