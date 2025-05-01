import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:kelola_barang/app/modules/landing/models/chart_data_in.dart';
import 'package:kelola_barang/app/modules/landing/models/chart_data_out.dart';
import 'package:kelola_barang/app/modules/landing/repositories/landing_repository.dart';

class LandingController extends GetxController {
  static LandingController get to => Get.find();
  final LandingRepository _repo = LandingRepository();
  RxInt profit = 0.obs;
  RxInt stokMasuk = 0.obs;
  RxInt stokKeluar = 0.obs;
  RxList<ChartDataIn> chartDataIn = <ChartDataIn>[].obs;
  RxList<ChartDataOut> chartDataOut = <ChartDataOut>[].obs;
  RxString selectedChart = 'out'.obs;
  Rxn<DateTimeRange> selectedRange = Rxn<DateTimeRange>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchStockIn();
    fetchStockOut();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void pickDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedRange.value = picked;

      final formattedStartDate = DateFormat('yyyy-MM-dd').format(picked.start);
      final formattedEndDate = DateFormat('yyyy-MM-dd').format(picked.end);

      await loadFilteredStockData(formattedStartDate, formattedEndDate);
    }
  }

  Future<void> loadFilteredStockData(String startDate, String endDate) async {
    print('Filtering stock data from $startDate to $endDate');

    try {
      final stockInData = await _repo.loadFilteredStockIn(startDate, endDate);
      final stockOutData = await _repo.loadFilteredStockOut(startDate, endDate);

      chartDataIn.assignAll(stockInData);
      chartDataOut.assignAll(stockOutData);
      setStokMasuk();
      setStokKeluar();

      print('Filtered Stock In loaded: ${stockInData.length}');
      print('Filtered Stock Out loaded: ${stockOutData.length}');
    } catch (e, stack) {
      print('❌ Error loading filtered stock data: $e');
      print(stack);
    }
  }

  void setStokMasuk() {
    stokMasuk.value = chartDataIn.length;
    ;
  }

  void setStokKeluar() {
    stokKeluar.value = chartDataOut.length;
  }

  void fetchStockIn() async {
    try {
      final data = await _repo.getStockIn();
      chartDataIn.assignAll(data);
    } catch (e) {
      print('Failed to fetch stock in: $e');
    }
  }

  void fetchStockOut() async {
    try {
      final data = await _repo.getStockOut();
      chartDataOut.assignAll(data);
    } catch (e) {
      print('Failed to fetch stock out: $e');
    }
  }
}
