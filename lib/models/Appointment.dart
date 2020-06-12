import './DateTimeUtils.dart';

class AppointmentModel {
  String date, time, id, doctorId;
  bool upcoming; //can be used to differentiate past and upcoming
  bool cancelled;
  Map<String, String> doctor = {};

  AppointmentModel.fromJson(Map<String, dynamic> json, String documentId) {
    DateTime dt = DateTimeUtils.convetTimeStampToDateTime(json["nextVisit"]);
    date = DateTimeUtils.getFormattedDate(dt);
    upcoming = json["cancelled"] != true && dt.isAfter(DateTime.now());
    cancelled = json["cancelled"] ?? false;
    time = DateTimeUtils.getFormattedTime(dt);
    doctor["name"] = json["doctorDetails"]["name"];
    doctor["type"] = json["doctorDetails"]["type"];
    doctor["city"] = json["doctorDetails"]["city"];
    doctorId = json["doctorId"];
    id = documentId;
  }
}
