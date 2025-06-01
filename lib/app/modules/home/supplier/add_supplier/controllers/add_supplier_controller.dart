import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kelola_barang/app/modules/home/models/contact.dart';
import 'package:kelola_barang/app/modules/home/supplier/controllers/supplier_controller.dart';
import 'package:kelola_barang/app/shared/constants/ad_constants.dart';

class AddSupplierController extends GetxController {
  final pc = Get.put(SupplierController());
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

  late final BannerAd bannerAd = BannerAd(
    adUnitId: AdConstants.bannerId,

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
  // ignore: unused_field
  List<Contact>? _contacts;
  RxString selectedPhoneNumber = ''.obs;

  void selectContact() async {
    final nativeContact = await _contactPicker.selectContact();
    if (nativeContact != null) {
      _contacts = [
        Contact(
          fullName: nativeContact.fullName ?? '',
          phoneNumbers: nativeContact.phoneNumbers,
        ),
      ];
      selectedPhoneNumber.value = nativeContact.phoneNumbers?.first ?? '';

      print('🧑‍💻 Selected Phone Number: ${selectedPhoneNumber.value}');
      pc.teleponC.text = nativeContact.phoneNumbers!.first;
      pc.namaPemasokC.text = nativeContact.fullName!;
    }
  }
}
