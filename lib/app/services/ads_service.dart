import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelola_barang/app/shared/constants/ad_constants.dart';

class AdsService {
  late final BannerAd bannerAd = BannerAd(
    adUnitId:
        Platform.isAndroid ? AdConstants.bannerId : AdConstants.iOSBannerId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        print('Ad loaded.');
      },
      onAdFailedToLoad: (ad, error) {
        print('Ad failed to load: $error');
        ad.dispose();
      },
    ),
  )..load();

  void dispose() {
    bannerAd.dispose();
  }
}
