import './DateTimeUtils.dart';

class PrescriptionModel {
  String createdDate, expiryDate, doctorId, instruction, medication, time;
  List<dynamic> symptoms, disease;
  Map<String, String> doctorDetails = {
    "name": "Dr. Ramoray",
    "type": "Orthopaedic"
  };
  Map<String, String> hospitalDetails = {
    "name": "KMS Hospital",
    "city": "Bengaluru"
  };

  PrescriptionModel.fromJson(json) {
    //this would throw error if

    DateTime dateTime = DateTimeUtils.convetTimeStampToDateTime(json["date"]);
    DateTime expiryDateTime =  DateTimeUtils.convetTimeStampToDateTime(json["expiry"]);
    createdDate = DateTimeUtils.getFormattedDate(dateTime);
    expiryDate = DateTimeUtils.getFormattedDate(expiryDateTime);
    time = DateTimeUtils.getFormattedTime(dateTime);
    medication = json["medication"] ?? "No Medication";
    instruction = json["instruction"] ?? "No Instruction";
    symptoms = json["symptoms"] ?? ["No Fever"];
    doctorId = json["doctorId"];
    doctorDetails["name"] = json["doctorDetails"]["name"] ?? "Dr. Ramoray";
    doctorDetails["type"] = json["doctorDetails"]["type"] ?? "Orthopaedic";
    hospitalDetails["name"] = json["hospitalDetails"]["name"] ?? "KMS Hospital";
    hospitalDetails["city"] = json["hospitalDetails"]["city"] ?? "Bengaluru";
    disease = json["disease"] ?? ["-ve Fever"];
  }
}
