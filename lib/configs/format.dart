import 'package:intl/intl.dart';

class Format {
  static String formatDateTimeToYYYYmm(DateTime dateTime) {
    return DateFormat('MM/yyyy').format(DateTime(2022, 10)).toString();
  }
}
