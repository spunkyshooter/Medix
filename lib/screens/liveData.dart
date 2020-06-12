import 'package:flutter/material.dart';
import 'package:medix/models/LiveDataModel.dart';
import 'package:medix/models/UserModel.dart';
import 'package:medix/services/Database.dart';
import 'package:medix/utils/index.dart';
import 'package:medix/widgets/liveCard.dart';
import 'package:provider/provider.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class LiveData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<UserModel>(context).uid;

    return StreamProvider<DocumentSnapshot>.value(
      value: DatabaseService(uid: uid).liveData,
      child: Consumer<DocumentSnapshot>(
        builder: (context, snapshot, child) {
          if(snapshot == null ) {
            return Center(child: CircularProgressIndicator());
          }
          final LiveDataModel data = new LiveDataModel.fromJson(snapshot.data);

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
                  data.moveable ? "Yes": "No",
                  "",
                  data.moveable ? "Normal": "Abnormal",
                  color: Colors.black,
                  bgClr: "FFFFFF", //"27A3AB"  greenish
                  img: "moveable.png",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
