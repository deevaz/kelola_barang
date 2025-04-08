import 'package:get/get.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeController extends GetxController {
  static BarcodeController get to => Get.find();

  RxString barcode = ''.obs;

  Future<void> scanBarcode() async {
    try {
      // String BarcodeScanRes;
      // BarcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      //   '#ff4370FB',
      //   'Batalkan',
      //   true,
      //   ScanMode.BARCODE,
      // );
      print('Kode barcode: ');
      // barcode.value = BarcodeScanRes;
    } catch (e) {
      print(e);
    }
  }
}
