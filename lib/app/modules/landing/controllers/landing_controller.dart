import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/history/controllers/history_controller.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/modules/landing/models/chart_data_in.dart';
import 'package:kelola_barang/app/modules/landing/models/chart_data_out.dart';
import 'package:kelola_barang/constants/api_constant.dart';

class LandingController extends GetxController {
  static LandingController get to => Get.find();
  RxInt omset = 0.obs;
  RxInt keuntungan = 10.obs;
  RxInt stokMasuk = 0.obs;
  RxInt stokKeluar = 0.obs;
  RxList<ChartDataIn> chartDataIn = <ChartDataIn>[].obs;
  RxList<ChartDataOut> chartDataOut = <ChartDataOut>[].obs;
  RxString selectedChart = 'out'.obs;

  var apiConstant = ApiConstant();
  final userId = HomeController.to.userId;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getStockIn();
    getStockOut();
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

  void getStockIn() {
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};
    var dio = Dio();
    dio
        .request(
          '${apiConstant.BASE_URL}/stockin/$userId',
          options: Options(method: 'GET', headers: headers),
        )
        .then((response) {
          if (response.statusCode == 200) {
            List<dynamic> decodedData = response.data;
            List<ChartDataIn> tempData =
                decodedData.map((item) => ChartDataIn.fromJson(item)).toList();
            chartDataIn.assignAll(tempData);
          } else {
            print(response.statusMessage);
          }
        })
        .catchError((error) {
          print('Error: $error');
        });
  }

  void getStockOut() {
    var token = HomeController.to.token;
    var headers = {'Authorization': 'Bearer $token'};

    var dio = Dio();
    dio
        .request(
          '${apiConstant.BASE_URL}/stockout/$userId',
          options: Options(method: 'GET', headers: headers),
        )
        .then((response) {
          if (response.statusCode == 200) {
            if (response.data != null) {
              List<dynamic> decodedData = response.data;
              List<ChartDataOut> tempData =
                  decodedData
                      .map((item) => ChartDataOut.fromJson(item))
                      .toList();
              chartDataOut.assignAll(tempData);
            } else {
              print('Response data is null');
            }
          } else {
            print(response.statusMessage);
          }
        })
        .catchError((error) {
          print('gagal ambil stock out: $error');
        });
  }
}
