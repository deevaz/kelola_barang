import 'package:get/get.dart';

import '../repositories/history_repository.dart';

class HistoryController extends GetxController {
  static HistoryController get to => Get.find();
  late final HistoryRepository repo;

  final RxList<Map<String, dynamic>> stokMasuk = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> stokKeluar = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> semuaRiwayat =
      <Map<String, dynamic>>[].obs;

  final isLoading = false.obs;

  Future<void> getHistory() async {
    isLoading.value = true;
    try {
      final bMasuk = await repo.fetchStokMasuk();
      final bKeluar = await repo.fetchStokKeluar();

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
    } catch (e) {
      print("Error fetching stok: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    repo = HistoryRepository();
    getHistory();
  }
}
