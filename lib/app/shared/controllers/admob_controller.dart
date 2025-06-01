import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

import 'package:kelola_barang/app/shared/constants/ad_constants.dart';

class AdmobController extends GetxController {
  Rx<BannerAd?> bannerAd = Rx<BannerAd?>(null);
  RxBool isBannerAdLoaded = false.obs;

  final String _bannerAdUnitId =
      Platform.isAndroid
          ? AdConstants.bannerId
          : 'ca-app-pub-3940256099942544/2934735716';

  void loadBannerAd() {
    bannerAd.value?.dispose();

    final ad = BannerAd(
      adUnitId: _bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd.value = ad as BannerAd;
          isBannerAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          isBannerAdLoaded.value = false;
          print('Banner ad failed to load: $error');
        },
      ),
    );

    ad.load();
  }

  void disposeBanner() {
    bannerAd.value?.dispose();
    bannerAd.value = null;
    isBannerAdLoaded.value = false;
  }
}
