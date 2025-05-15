import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/modules/history/models/history_response_model.dart';
import 'package:kelola_barang/app/modules/history/repositories/history_repository.dart';
import 'package:kelola_barang/app/modules/history/services/pdf_service.dart';
import 'package:printing/printing.dart';
import 'package:logger/logger.dart';

class HistoryController extends GetxController {
  static HistoryController get to => Get.find();

  final RxList<HistoryResponseModel> history = <HistoryResponseModel>[].obs;
  late final HistoryRepository _repo;
  final PdfService _pdfService = PdfService();
  Rxn<DateTimeRange> selectedRange = Rxn<DateTimeRange>();
  var logger = Logger();

  final isLoading = false.obs;
  void printDocument() async {
    try {
      final pdf = await _pdfService.generatePdf(history: history);

      await Printing.layoutPdf(onLayout: (format) async => pdf.save());
    } catch (e) {
      print("Error saat print: $e");
    }
  }

  void clearFilter() {
    selectedRange.value = null;
    history.clear();
    loadHistory();
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

      await loadFilteredHistory(formattedStartDate, formattedEndDate);
    }
  }

  Future<void> loadHistory() async {
    try {
      final data = await _repo.fetchHistory();
      history.clear();
      history.assignAll(data);
      print('History: $history');
      logger.i('History loaded successfully');
    } catch (e) {
      logger.e('Error loading history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadFilteredHistory(String start, String end) async {
    try {
      final data = await _repo.fetchFilteredHistory(start, end);
      history.clear();
      history.assignAll(data);
      print('Filtered History: $history');
      logger.i('Filtered history loaded successfully $start - $end ');
    } catch (e) {
      logger.e('Error loading filtered history: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _repo = HistoryRepository();
    loadHistory();
  }
}
