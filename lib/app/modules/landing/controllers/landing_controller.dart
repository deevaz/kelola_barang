import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';

class LandingController extends GetxController {
  RxInt omset = 0.obs;
  RxInt keuntungan = 10.obs;
  RxInt stokMasuk = 0.obs;
  RxInt stokKeluar = 0.obs;

  @override
  void onInit() {
    super.onInit();
    setStokMasuk();
    setStokKeluar();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setOmset(int value) {
    omset.value = value;
  }

  void setKeuntungan(int value) {
    keuntungan.value = value;
  }

  void setStokMasuk() {
    print('Stok Masuk: ${HistoryController.to.stokMasuk.length}');
    stokMasuk.value = HistoryController.to.stokMasuk.length;
    ;
  }

  void setStokKeluar() {
    print('Stok Keluar: ${HistoryController.to.stokKeluar.length}');
    stokKeluar.value = HistoryController.to.stokKeluar.length;
  }
}
