import 'package:intl/intl.dart';

class FormatUtils {
  static String formatCurrency(int value ){
    var currency = NumberFormat.currency(locale: 'es_CO', name: 'COP', decimalDigits: 0);
    return currency.format(value);
  }
}