import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medix/models/LiveDataModel.dart';
import 'package:medix/models/UserModel.dart';
import 'package:medix/services/Database.dart';
import 'package:medix/utils/index.dart';
import 'package:medix/widgets/CustomCard.dart';
import 'package:medix/widgets/infoBox.dart';
import 'package:medix/widgets/liveCard.dart';
import 'package:provider/provider.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class LiveData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<FirebaseUser>(context).uid;
    print("live data page");
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "How is your Health?",
              style: TextStyle(
                  color: hexToColor("000000"),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
          ),
          StreamProvider<DocumentSnapshot>.value(
            value: DatabaseService(uid: uid).liveData,
            child:
                Consumer<DocumentSnapshot>(builder: (context, snapshot, child) {
              if (snapshot == null) {
                return Center(child: CircularProgressIndicator());
              }
              final LiveDataModel data =
                  new LiveDataModel.fromJson(snapshot.data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LiveCard(
                    "Heart Rate",
                    data.heartRate,
                    "bpm",
                    data.status["heartRate"],
                    color: Colors.black,
                    bgClr: "FADB39",
                    img: "heart2.png",
                  ),
                  LiveCard(
                    "Respiratory Rate",
                    data.respiratoryRate,
                    "Bpm",
                    data.status["respiratoryRate"],
                    color: Colors.white,
                    bgClr: "0085FF", //"0068FF",
                    img: "lung.png",
                  ),
                  LiveCard(
                    "Blood Pressure",
                    data.bloodPressure,
                    "mmHg",
                    data.status["bloodPressure"],
                    color: Colors.white,
                    bgClr: "FE6363",
                    img: "bloodPressure.png",
                  ),
                  LiveCard(
                    "Moveable",
                    data.moveable ? "Yes" : "No",
                    "",
                    data.moveable ? "Normal" : "Abnormal",
                    color: Colors.black,
                    bgClr: "FFFFFF", //"27A3AB"  greenish
                    img: "moveable.png",
                  ),
                  LiveCardDoctor(
                    doctorId: data.doctorId,
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class LiveCardDoctor extends StatelessWidget {
  LiveCardDoctor({this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<FirebaseUser>(context).uid;
    DatabaseService _DbService = new DatabaseService(uid: uid);
    return FutureBuilder<DocumentSnapshot>(
      future: doctorId == null
          ? Future.delayed(Duration(seconds: 0))
          : _DbService.doctorOfLiveData(doctorId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final doctor = snapshot.data.data;
          return CustomCard(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InfoBox("Managed By", doctor["name"]),
                  SizedBox(
                    height: 20,
                  ),
                  InfoBox(
                    "Email",
                    doctor["email"],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InfoBox(
                    "Phone",
                    doctor["phone"],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InfoBox(
                        "Hospital",
                        doctor["hospital"]["name"],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      RaisedButton(
                        color: hexToColor("FE6363"),
                        onPressed: () {
                          _DbService.revokeDoctorFromLiveData();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Revoked",
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: Text(
                          "Revoke",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return CustomCard(
          child: InfoBox(
            "Note",
            "Data is not managed by anyone",
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        );
      },
    );
  }
}
