import './DateTimeUtils.dart';

class AppointmentModel {
  String date, time, id, doctorId;
  bool upcoming; //can be used to differentiate past and upcoming
  int status; //0 : to be done, 1: done, 2: cancelled
  Map<String, String> doctor = {};

  AppointmentModel.fromJson(Map<String, dynamic> json, String documentId) {
    DateTime dt = DateTimeUtils.convetTimeStampToDateTime(json["nextVisit"]);
    date = DateTimeUtils.getFormattedDate(dt);
    upcoming = json["status"] == 0 && dt.isAfter(DateTime.now());
    status = json["status"] ?? 0;
    time = DateTimeUtils.getFormattedTime(dt);
    doctor["name"] = json["doctorDetails"]["name"];
    doctor["type"] = json["doctorDetails"]["type"];
    doctor["city"] = json["doctorDetails"]["city"];
    doctorId = json["doctorId"];
    id = documentId;
  }
}
