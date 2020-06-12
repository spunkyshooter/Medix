import './DateTimeUtils.dart';

class PatientModel {
  String uid, name, phone, address, bloodGroup, email, gender;
  String age, lastVisit;

  PatientModel.fromJson(json) {
    print(json.toString());
    uid = json["uid"];
    name = json["name"];
    phone = json["phone"];
    address = json["address"];
    bloodGroup = json["bloodGroup"];
    email = json["email"];
    gender = json["gender"];
    DateTime _dob = DateTimeUtils.convetTimeStampToDateTime(json["dob"]);
    DateTime lstvisit =
        DateTimeUtils.convetTimeStampToDateTime(json["lastVisit"]);
    age = (DateTime.now().year - _dob.year).toString();
    lastVisit = DateTimeUtils.getFormattedTime(lstvisit);
  }
}

//TODO: height and weight