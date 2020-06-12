import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeUtils {
  static List<String> mnth = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  static DateTime convetTimeStampToDateTime(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }
  static String getFormattedDate(DateTime dateTime,{bool fullYr = false}) {
    int yr = dateTime.year;
    return "${dateTime.day} ${mnth[dateTime.month - 1]} ${fullYr ? yr : yr.toString().substring(0, 2)}";
  }

  static String getFormattedTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute} ${dateTime.hour > 12 ? "PM" : "AM"}";
  }
}
