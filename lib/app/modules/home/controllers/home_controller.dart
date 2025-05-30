import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:kelola_barang/app/modules/home/models/chart_data_in.dart';
import 'package:kelola_barang/app/modules/home/models/chart_data_out.dart';
import 'package:kelola_barang/app/modules/home/repositories/home_repository.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final HomeRepository _repo = HomeRepository();
  RxInt profit = 0.obs;
  RxInt stokMasuk = 0.obs;
  RxInt stokKeluar = 0.obs;
  RxList<ChartDataIn> chartDataIn = <ChartDataIn>[].obs;
  RxList<ChartDataOut> chartDataOut = <ChartDataOut>[].obs;
  RxString selectedChart = 'out'.obs;
  Rxn<DateTimeRange> selectedRange = Rxn<DateTimeRange>();
  Logger log = Logger();
  final GlobalKey one = GlobalKey();
  final GlobalKey two = GlobalKey();
  final GlobalKey three = GlobalKey();
  final GlobalKey four = GlobalKey();
  final GlobalKey five = GlobalKey();
  final GlobalKey six = GlobalKey();
  final box = GetStorage();

  @override
  void onReady() {
    super.onReady();
    fetchStockIn();
    fetchStockOut();
  }

  void clearFilter() {
    selectedRange.value = null;
    chartDataIn.clear();
    chartDataOut.clear();
    fetchStockIn();
    fetchStockOut();
    setStokMasuk();
    setStokKeluar();
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
      final stockInData = await _repo.fetchFilteredStockIn(startDate, endDate);
      final stockOutData = await _repo.fetchFilteredStockOut(
        startDate,
        endDate,
      );

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
    print('Stok Masuk: ${chartDataIn.length}');
  }

  void setStokKeluar() {
    stokKeluar.value = chartDataOut.length;
    print('Stok Keluar: ${chartDataOut.length}');
  }

  void fetchStockIn() async {
    try {
      final data = await _repo.fetchStockIn();
      chartDataIn.assignAll(data);
      setStokMasuk();
    } catch (e) {
      print('Failed to fetch stock in: $e');
    }
  }

  void fetchStockOut() async {
    try {
      final data = await _repo.fetchStockOut();
      chartDataOut.assignAll(data);
      setStokKeluar();
    } catch (e) {
      print('Failed to fetch stock out: $e');
    }
  }
}
