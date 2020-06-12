//creating model is beneficiary since if we come back after long time
//we will know what data we are expecting from backend at one place
//other benefit is we can access properties ex: .heartRate instead of json["heartRate"]
//it would be ugly in case of nested data

class LiveDataModel {
  String bloodPressure, doctorId, respiratoryRate;
  String heartRate;

//  String patientId; Not needed
  bool moveable;

  Map<String, String> status = {}; //creating an instance of map

  LiveDataModel.fromJson(json) {
    bloodPressure = json["bloodPressure"]; //
    doctorId = json["doctorId"];
//    patientId = json["patientId"];
    respiratoryRate = json["respiratoryRate"]; //12-20
    heartRate = json["heartRate"].toString();
    moveable = json["moveable"];

    _setStatus();
  }

  _setStatus() {
    List<int> bP = bloodPressure.split("/").map((e) => int.parse(e)).toList();
    List<int> rR = respiratoryRate.split("-").map((e) => int.parse(e)).toList();
    int hR = int.parse(heartRate);

    //systolic (higher) is first element
    status["bloodPressure"] = _getStatus(bP[1], bP[0], "bloodPressure");
    status["respiratoryRate"] = _getStatus(rR[0], rR[1], "respiratoryRate");
    status["heartRate"] = _getStatus(hR, hR, "heartRate");
  }

  static const thresholds = {
    "bloodPressure": {"max": 120, "min": 80},
    "respiratoryRate": {"max": 20, "min": 12},
    "heartRate": {"max": 100, "min": 60}
  };

  String _getStatus(int min, int max, String thershold) {
    if (min < thresholds[thershold]["min"]) {
      //min
      return 'Low';
    } else if (max > thresholds[thershold]["max"]) {
      return 'High';
    } else {
      return 'Normal';
    }
  }
}
