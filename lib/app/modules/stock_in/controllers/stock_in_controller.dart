import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/stock_in/models/product_in_model.dart';
import '../models/stock_in_request_model.dart';
import '../repositories/stock_in_repository.dart';

class StockInController extends GetxController {
  static StockInController get to => Get.find();
  final StockInRepository _repo = StockInRepository();
  final catatanC = TextEditingController();
  final RxString selectedSupplier = ''.obs;
  final RxInt totalPrice = 0.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxList<ProductInModel> stockInData = <ProductInModel>[].obs;

  void setSelectedDate(DateTime? date) {
    selectedDate.value = date;
  }

  Future<void> addStockIn() async {
    final stockData = StockInRequestModel(
      pemasok: selectedSupplier.value,
      catatan: catatanC.text,
      tanggalMasuk: selectedDate.value?.toIso8601String() ?? '',
      totalHarga: totalPrice.value,
      barang:
          stockInData.map((item) {
            return Barang(
              nama: item.namaBarang,
              harga: item.harga,
              jumlahStokMasuk: item.jumlahstokMasuk,
              totalStok: item.stok,
            );
          }).toList(),
    );
    _repo.postStockIn(stockData);
  }

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2041),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        selectedDate.value = combinedDateTime;
      }
    }
  }
}
