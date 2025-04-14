import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/stock_in/models/supplier_model.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/constants/api_constant.dart';

import '../models/stock_in_model.dart';

class StockInController extends GetxController {
  static StockInController get to => Get.find();

  final catatanC = TextEditingController();
  final RxList<SupplierModel> selectedSupplier = <SupplierModel>[].obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  final dio = Dio();
  final userId = HomeController.to.userId.value;

  var apiConstant = ApiConstant();

  void setSelectedDate(DateTime? date) {
    selectedDate.value = date;
  }

  void addItem(SupplierModel item) {
    selectedSupplier.clear();
    selectedSupplier.add(item);
  }

  Future<void> postStockIn() async {
    final stockData = StockInModel(
      pemasok: "Nopal Firman",
      catatan: catatanC.text,
      tanggalMasuk: selectedDate.value?.toIso8601String() ?? '',
      totalHarga: 10000,
      barang: [
        Barang(
          nama: "Keripik",
          harga: 1000,
          jumlahStokMasuk: 10,
          totalStok: 10,
        ),
        Barang(nama: "Ginjal", harga: 2000, jumlahStokMasuk: 29, totalStok: 7),
      ],
    );
    try {
      var token = await HomeController.to.token.value;
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
          'Berhasil',
          'Stock Masuk berhasil disimpan',
          backgroundColor: ColorStyle.success,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');
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

  @override
  void onInit() {
    super.onInit();
  }
}
