import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/services/pdf_service.dart';
import 'package:kelola_barang/app/modules/landing/controllers/landing_controller.dart';
import 'package:printing/printing.dart';

import '../services/history_service.dart';

class HistoryController extends GetxController {
  static HistoryController get to => Get.find();

  final RxList<Map<String, dynamic>> stokMasuk = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> stokKeluar = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> semuaRiwayat =
      <Map<String, dynamic>>[].obs;
  late final HistoryService _historyService;
  final PdfService _pdfService = PdfService();

  final isLoading = false.obs;
  // ! alert success
  void printDocument() async {
    try {
      final pdf = await _pdfService.generatePdf(
        stokMasuk: stokMasuk,
        stokKeluar: stokKeluar,
      );

      await Printing.layoutPdf(onLayout: (format) async => pdf.save());
    } catch (e) {
      print("Error saat print: $e");
    }
  }

  Future<void> getHistory() async {
    isLoading.value = true;
    try {
      final bMasuk = await _historyService.fetchStokMasuk();
      final bKeluar = await _historyService.fetchStokKeluar();

      final listStokMasuk = List<Map<String, dynamic>>.from(bMasuk);
      stokMasuk.assignAll(listStokMasuk);
      final listStokKeluar = List<Map<String, dynamic>>.from(bKeluar);
      stokKeluar.assignAll(listStokKeluar);

      final riwayatMasuk =
          listStokMasuk.map((e) {
            return {
              'tanggal': e['tanggal_masuk'],
              'tipe': 'masuk',
              'isStokMasuk': true,
              'isStokKeluar': false,
              ...e,
            };
          }).toList();
      final riwayatKeluar =
          listStokKeluar.map((e) {
            return {
              'tanggal': e['tanggal_keluar'],
              'tipe': 'keluar',
              'isStokMasuk': false,
              'isStokKeluar': true,
              ...e,
            };
          }).toList();

      semuaRiwayat.assignAll([...riwayatMasuk, ...riwayatKeluar]);

      semuaRiwayat.sort((a, b) => b['tanggal'].compareTo(a['tanggal']));

      print('Semua riwayat: ${semuaRiwayat.length}');
      for (var riwayat in semuaRiwayat) {
        print(
          '${riwayat['tanggal']} - ${riwayat['tipe']} - masuk? ${riwayat['isStokMasuk']}, keluar? ${riwayat['isStokKeluar']}',
        );
      }
      print(
        'History fetched ${stokMasuk.length} dan keluar ${stokKeluar.length}',
      );
      LandingController.to.setStokMasuk();
      LandingController.to.setStokKeluar();
    } catch (e) {
      print("Error fetching stok: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _historyService = HistoryService();
    getHistory();
  }
}
