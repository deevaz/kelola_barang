import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/modules/history/models/history_model.dart'
    as history;
import 'package:kelola_barang/app/modules/history/models/stock_in_response_model.dart'
    as stockin;
import 'package:kelola_barang/app/modules/history/models/stock_out_response_model.dart'
    as stockout;
import 'package:kelola_barang/app/modules/history/repositories/history_repository.dart';
import 'package:kelola_barang/app/modules/history/services/pdf_service.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:printing/printing.dart';
import 'package:logger/logger.dart';

class HistoryController extends GetxController {
  static HistoryController get to => Get.find();

  final RxList<stockin.StockInResponseModel> stokMasuk =
      <stockin.StockInResponseModel>[].obs;
  final RxList<stockout.StockOutResponseModel> stokKeluar =
      <stockout.StockOutResponseModel>[].obs;
  final RxList<history.HistoryModel> semuaRiwayat =
      <history.HistoryModel>[].obs;
  late final HistoryRepository _historyRepo;
  final PdfService _pdfService = PdfService();
  Rxn<DateTimeRange> selectedRange = Rxn<DateTimeRange>();
  var logger = Logger();

  final isLoading = false.obs;
  // void printDocument() async {
  //   try {
  //     final pdf = await _pdfService.generatePdf(
  //       stokMasuk: stokMasuk,
  //       stokKeluar: stokKeluar,
  //     );

  //     await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  //   } catch (e) {
  //     print("Error saat print: $e");
  //   }
  // }

  void clearFilter() {
    selectedRange.value = null;
    semuaRiwayat.clear();
    stokMasuk.clear();
    stokKeluar.clear();
    getHistory();
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

      // await loadFilteredStockData(formattedStartDate, formattedEndDate);
    }
  }

  Future<void> loadStockOut() async {
    Logger().i('Loading stock out data');
    try {
      final stockOutData = await _historyRepo.fetchStokKeluar();
      stokKeluar.assignAll(stockOutData);
      logger.i(
        'Stock out data loaded successfully: ${stokKeluar.length} items',
      );
    } catch (e) {
      logger.e("Error saat load stok keluar", error: e);
    }
  }

  Future<void> loadStockIn() async {
    Logger().i('Loading stock in data');
    try {
      final stockInData = await _historyRepo.fetchStokMasuk();
      stokMasuk.assignAll(stockInData);
      logger.i('Stock in data loaded successfully: ${stokMasuk.length} items');
    } catch (e) {
      logger.e("Error saat load stok masuk", error: e);
    }
  }

  // Future<void> loadFilteredStockData(String startDate, String endDate) async {
  //   print('Filtering stock data from $startDate to $endDate');

  //   try {
  //     final stockInData = await _historyRepo.fetchStokMasukByDate(
  //       startDate,
  //       endDate,
  //     );
  //     final stockOutData = await _historyRepo.fetchStokKeluarByDate(
  //       startDate,
  //       endDate,
  //     );

  //     final listStokMasuk = List<Map<String, dynamic>>.from(stockInData);
  //     stokMasuk.assignAll(listStokMasuk);
  //     final listStokKeluar = List<Map<String, dynamic>>.from(stockOutData);
  //     stokKeluar.assignAll(listStokKeluar);

  //     final riwayatMasuk =
  //         listStokMasuk.map((e) {
  //           return {
  //             'tanggal': e['tanggal_masuk'],
  //             'tipe': 'masuk',
  //             'isStokMasuk': true,
  //             'isStokKeluar': false,
  //             ...e,
  //           };
  //         }).toList();
  //     final riwayatKeluar =
  //         listStokKeluar.map((e) {
  //           return {
  //             'tanggal': e['tanggal_keluar'],
  //             'tipe': 'keluar',
  //             'isStokMasuk': false,
  //             'isStokKeluar': true,
  //             ...e,
  //           };
  //         }).toList();

  //     semuaRiwayat.assignAll([...riwayatMasuk, ...riwayatKeluar]);

  //     semuaRiwayat.sort((a, b) => b['tanggal'].compareTo(a['tanggal']));

  //     print('Semua riwayat: ${semuaRiwayat.length}');
  //     for (var riwayat in semuaRiwayat) {
  //       print(
  //         '${riwayat['tanggal']} - ${riwayat['tipe']} - masuk? ${riwayat['isStokMasuk']}, keluar? ${riwayat['isStokKeluar']}',
  //       );
  //     }
  //   } catch (e) {
  //     print("Error saat filter: $e");
  //   }
  // }

  Future<void> getHistory() async {
    // try {
    //   await loadStockIn();
    //   await loadStockOut();

    //   final riwayatMasuk =
    //       stokMasuk.map((e) {
    //         return history.HistoryModel(
    //           tanggal: e.tanggalMasuk!,
    //           tipe: 'masuk',
    //           isStokMasuk: true,
    //           isStokKeluar: false,
    //           id: int.tryParse(e.id ?? '') ?? 0,
    //           pemasok: e.pemasok,
    //           pembeli: null,
    //           userId: int.tryParse(e.userId ?? '') ?? 0,
    //           catatan: e.catatan,
    //           totalHarga: double.tryParse(e.totalHarga ?? '0') ?? 0.0,
    //           tanggalMasuk: e.tanggalMasuk,
    //           tanggalKeluar: null,
    //           totalMasuk: e.totalMasuk,
    //           totalKeluar: null,
    //           barang: e.barang,
    //         );
    //       }).toList();

    //   final riwayatKeluar =
    //       stokKeluar.map((e) {
    //         return history.HistoryModel(
    //           tanggal: e.tanggalKeluar!,
    //           tipe: 'keluar',
    //           isStokMasuk: false,
    //           isStokKeluar: true,
    //           id: int.tryParse(e.id ?? '') ?? 0,
    //           pemasok: null,
    //           pembeli: e.pembeli,
    //           userId: int.tryParse(e.userId ?? '') ?? 0,
    //           catatan: e.catatan,
    //           totalHarga: double.tryParse(e.totalHarga ?? '0') ?? 0.0,
    //           tanggalMasuk: null,
    //           tanggalKeluar: e.tanggalKeluar,
    //           totalMasuk: null,
    //           totalKeluar: e.totalKeluar,
    //           barang: e.barang ?? <stockout.Barang>[],
    //         );
    //       }).toList();

    //   semuaRiwayat.assignAll([...riwayatMasuk, ...riwayatKeluar]);

    //   semuaRiwayat.sort((a, b) => b.tanggal.compareTo(a.tanggal));
    // } catch (e) {
    //   logger.e("Error saat ambil data history", error: e);
    // } finally {
    //   isLoading.value = false;
    // }
  }

  @override
  void onInit() {
    super.onInit();
    _historyRepo = HistoryRepository();
    getHistory();
  }
}
