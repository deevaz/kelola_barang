import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:kelola_barang/app/modules/history/models/history_response_model.dart';
import 'package:kelola_barang/app/modules/history/repositories/history_repository.dart';
import 'package:kelola_barang/app/modules/history/services/pdf_service.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/services/snackbar_service.dart';
import 'package:kelola_barang/app/shared/constants/ad_constants.dart';
import 'package:printing/printing.dart';
import 'package:logger/logger.dart';

class HistoryController extends GetxController {
  static HistoryController get to => Get.find();

  final RxList<HistoryResponseModel> history = <HistoryResponseModel>[].obs;
  late final HistoryRepository _repo;
  final PdfService _pdfService = PdfService();
  Rxn<DateTimeRange> selectedRange = Rxn<DateTimeRange>();
  var logger = Logger();

  RewardedAd? _rewardedAd;
  final isAdLoaded = false.obs;
  final rewardEarned = false.obs;

  void loadAd() {
    RewardedAd.load(
      adUnitId: AdConstants.rewardId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          _rewardedAd = ad;
          isAdLoaded.value = true;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _rewardedAd = null;
              isAdLoaded.value = false;
              loadAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _rewardedAd = null;
              isAdLoaded.value = false;
              loadAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          logger.e('RewardedAd failed to load: $error');
          isAdLoaded.value = false;
          Future.delayed(const Duration(seconds: 30), loadAd);
        },
      ),
    );
  }

  void showRewardedAd({required Function func}) {
    if (isAdLoaded.value && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          SnackbarService.success('success'.tr, 'reward-earned'.tr);
          func();
        },
      );
    } else {
      SnackbarService.warning('failed'.tr, 'ads-loading'.tr);
      loadAd();
    }
  }

  final isLoading = false.obs;
  void printDocument() async {
    try {
      final pdf = await _pdfService.generatePdf(history: history);
      await Printing.layoutPdf(onLayout: (format) async => pdf.save());
      if (_rewardedAd != null) {
        _rewardedAd!.dispose();
        _rewardedAd = null;
        isAdLoaded.value = false;
      }
    } catch (e) {
      logger.e('Error generating PDF: $e');
      SnackbarService.error('error'.tr, 'error-generating-pdf'.tr);
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

  Future<void> deleteHistory(String id, String tipe) async {
    await _repo.deleteHistory(id, tipe);
    loadHistory();
    HomeController.to.fetchStockIn();
    HomeController.to.fetchStockOut();
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
