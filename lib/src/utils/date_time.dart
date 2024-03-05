import 'package:intl/intl.dart';

class DateTimeFormat {
  DateTime dateTime = DateTime.now();
  String getDateTime() {
    return dateTime.toString();
  }

  String getDate(String date) {
    //"date/month/year(last 2 digits)"
    return DateFormat.yMd().format(DateTime.parse(date));
  }

  String getDisplayDate(String displayDate) {
    List date =
        DateFormat.MMMd().format(DateTime.parse(displayDate)).split(" ");
    // "date, month in letter(1st 3 letters)"
    return "${date[1]} ${date[0]}";
  }

  String getTime(String time) {
    // "hrs.minutes am/pm"
    return DateFormat.jm().format(DateTime.parse(time)).toLowerCase();
  }

  String getDisplayDateAndTime(date) {
    return DateFormat('dd MMM yyyy').format(DateTime.parse(date)) +
        DateFormat(', hh:mm a').format(DateTime.parse(date)).toLowerCase();
  }

  int getDaysDifference(String startDate) {
    DateTime start = DateFormat('M/d/yyyy').parse(startDate);
    DateTime end = DateFormat('M/d/yyyy').parse(getDate(getDateTime()));
    return end.difference(start).inDays;
  }
}
