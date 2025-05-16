import 'package:intl/intl.dart';

class CurrencyService {
  String formatToIdr(num number) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(number);
  }
}
