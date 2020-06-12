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

  //create streams
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

  //SET DATA

  Future cancelAppointment (String documentId) async {
    return await reference("schedule").document(documentId).setData({"cancelled":true},merge:true);
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
        .map((pres) => new AppointmentModel.fromJson(pres.data, pres.documentID))
        .toList();
    return list;
  }
}
