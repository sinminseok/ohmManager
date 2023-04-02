import 'package:intl/intl.dart';


String getToday() {
  var strToday;
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  strToday = formatter.format(now);
  return strToday;
}

fillter(date_time_string) {
  var current_datetime = date_time_string.substring(0, 4) +
      "년" +
      date_time_string.substring(5, 7) +
      "월" +
      date_time_string.substring(8, 10) +
      "일 " +
      date_time_string.substring(11, 13) +
      ":" +
      date_time_string.substring(14, 16) +
      "분";

  return current_datetime;
}