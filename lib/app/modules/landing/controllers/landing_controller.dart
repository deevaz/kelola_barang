import 'package:get/get.dart';

class LandingController extends GetxController {
  RxInt omset = 0.obs;
  RxInt keuntungan = 10.obs;
  RxInt stokMasuk = 0.obs;
  RxInt stokKeluar = 0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
