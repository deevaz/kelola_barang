import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/modules/stock_out/repositories/stock_out_repository.dart';
import 'package:kelola_barang/app/shared/constants/ad_constants.dart';

import '../models/product_out_model.dart';
import '../models/stock_out_model.dart';

class StockOutController extends GetxController {
  static StockOutController get to => Get.find();
  final StockOutRepository _repo = StockOutRepository();
  final noteC = TextEditingController();
  final buyerC = TextEditingController();
  final RxString selectedBuyer = ''.obs;
  final RxInt totalPrice = 0.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxList<ProductOutModel> stockOutData = <ProductOutModel>[].obs;

  final dio = Dio();
  final userId = BaseController.to.userId.value;

  late final BannerAd bannerAd = BannerAd(
    adUnitId:
        Platform.isAndroid
            ? AdConstants.bannerId
            : 'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        print('Ad loaded.');
      },
      onAdFailedToLoad: (ad, error) {
        print('Ad failed to load: $error');
        ad.dispose();
      },
    ),
  )..load();

  void setSelectedDate(DateTime? date) {
    selectedDate.value = date;
  }

  Future<void> addStockOut() async {
    final stockData = StockOutRequestModel(
      pembeli: buyerC.text,
      catatan: noteC.text,
      tanggalKeluar: selectedDate.value?.toIso8601String() ?? '',
      totalHarga: totalPrice.value,
      barang:
          stockOutData.map((item) {
            return Barang(
              nama: item.namaBarang,
              harga: item.harga,
              jumlahStokKeluar: item.jumlahStokKeluar,
              totalStok: item.stok,
            );
          }).toList(),
    );

    _repo.postStockOut(stockData);
  }

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2041),
    );

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final combinedDateTime = DateTime(
        pickedDate!.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      selectedDate.value = combinedDateTime;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
