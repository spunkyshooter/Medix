import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medix/models/Appointment.dart';

//import 'package:medix/models/LiveDataModel.dart';
import 'package:medix/models/percription.dart';

//creating a model for this service.
//this abstracts most things and exposes some useful methods to be used
class DatabaseService {
  //to link the user to database.
  String uid;

  DatabaseService({this.uid});

  //create the instance
  static final Firestore _firestore = Firestore.instance;

  //create references
  //collectionName: "patients" / "prescription" / "liveData"
  static reference(collectionName) => _firestore.collection(collectionName);

  //STREAMS

  //GOTCHAS: If we return DocumentSnapshot / QuerySnapshot in the stream
  //Then in case of multiple streams in the ancestors, then accessing the
  //former streams would be not possible
  //Provider.of<DocumentSnapshot>(context) will return the nearest matching stream;

  Stream<DocumentSnapshot> get patient {
    return reference("patients").document(uid).snapshots();
  }

  Stream<DocumentSnapshot> get liveData {
    return reference("LiveData").document(uid).snapshots(); //NOTE: caps L
  }

  Stream<QuerySnapshot> prescription(List<DateTime> dateRange) {
    return reference("prescriptions")
        .where("date", isGreaterThanOrEqualTo: dateRange[0])
        .where("date", isLessThanOrEqualTo: dateRange[1])
        .where("patientId", isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot> get appointment {
    return reference("schedule").where("patientId", isEqualTo: uid).snapshots();
  }

  Stream<DocumentSnapshot> get requests {
    return reference("requests").document(uid).snapshots();
  }

  //FUTURES

  //GET DATA
  Future<DocumentSnapshot> doctorOfLiveData(doctorId) {
    return reference("doctors").document(doctorId).get();
  }

  //SET DATA

  Future cancelAppointment(String documentId) async {
    return await reference("schedule")
        .document(documentId)
        .setData({"status": 2}, merge: true);
  }

  //@params value = -1 / 1 / 0
  //None: -1
  //Yes: 1
  //No: 0
  Future acceptOrDeclineRequest(int value) async {
    return await reference("requests")
        .document(uid)
        .setData({"accepted": value}, merge: true);
  }

  Future createPatient({
    String name,
    String address,
    String bloodGroup,
    DateTime dob,
    String email,
    String gender,
    String phone,
  }) async {
    return await reference("patients").document(uid).setData({
      "address": address,
      "bloodGroup": bloodGroup,
      "dob": dob,
      "email": email,
      "gender": gender,
      "name": name,
      "phone": phone,
      "uid": uid,
    });
  }

  Future addLiveData() async {
    return await reference("LiveData").document(uid).setData({
      "bloodPressure": "120/80",
//      "doctorId": , Doctor would request for that
      "heartRate": 70,
      "moveable": true,
      "patientId": uid,
      "respiratoryRate": "12-20",
    });
  }

  //DELETE DATA
  Future revokeDoctorFromLiveData() async {
    return await reference("LiveData").document(uid).updateData(
        {"doctorId": FieldValue.delete()}); //deleting a field inside a document
  }

  //HELPERS

  static List<PrescriptionModel> prescriptionModelsFromSnapShot(
      QuerySnapshot snapshots) {
    final List<PrescriptionModel> list = snapshots.documents
        .map((pres) => new PrescriptionModel.fromJson(pres.data))
        .toList();
    return list;
  }

  static List<AppointmentModel> appointmentModelsFromSnapShot(
      QuerySnapshot snapshots) {
    final List<AppointmentModel> list = snapshots.documents
        .map(
            (pres) => new AppointmentModel.fromJson(pres.data, pres.documentID))
        .toList();
    return list;
  }
}
