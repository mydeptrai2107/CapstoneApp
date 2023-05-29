import 'package:intl/intl.dart';

class Format {
  static String formatDateTimeToYYYYmm(DateTime dateTime) {
    return DateFormat('MM/yyyy').format(dateTime).toString();
  }

  static String formatDateTimeToYYYYmmdd(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime).toString();
  }

  static String formatDateTimeToYYYYmmHHmm(DateTime dateTime) {
    return DateFormat.yMd().add_jm().format(dateTime).toString();
  }

  static String getFirstNameByName(String name) {
    List<String> value = name.split(" ");
    return value[0];
  }

  static String getLastNameByName(String name) {
    List<String> value = name.split(" ");
    return value[1];
  }
}
