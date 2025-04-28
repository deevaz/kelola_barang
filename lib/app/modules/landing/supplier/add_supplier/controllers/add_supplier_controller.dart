import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/landing/models/contact.dart';
import 'package:kelola_barang/app/modules/landing/supplier/controllers/supplier_controller.dart';

class AddSupplierController extends GetxController {
  final pc = Get.put(SupplierController());
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();

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
