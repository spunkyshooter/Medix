import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:medix/models/DateTimeUtils.dart';
import 'package:medix/models/UserModel.dart';
import 'package:medix/models/percription.dart';
import 'package:medix/screens/prescriptionDetails.dart';
import 'package:medix/services/Database.dart';
import 'package:medix/utils/index.dart';
import 'package:medix/widgets/CardWithInfoBox.dart';
import 'package:medix/widgets/ColumnBlock.dart';
import 'package:medix/widgets/CustomCard.dart';
import 'package:medix/widgets/infoBox.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:provider/provider.dart';

class MedicalHistory extends StatefulWidget {
  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  List<DateTime> dateRange = [
    DateTime.now().subtract(Duration(hours: Duration.hoursPerDay * 10)),
    //-ve 10 days
    DateTime.now()
    //present
  ];

  _onPressed(BuildContext context) async {
    final dateResult = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: DateTime.now(),
      initialLastDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      //for calendar
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (dateResult != null && dateResult.length == 2) {
      setState(() {
        dateRange = dateResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
    final String uid = Provider.of<UserModel>(context).uid;
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService(uid: uid).prescription(dateRange),
      child: Consumer<QuerySnapshot>(
        builder: (context, data, child) {
          if (data == null) {
            return Center(child: CircularProgressIndicator());
          }
          List<PrescriptionModel> prescriptions =
              DatabaseService.prescriptionModelsFromSnapShot(data);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              //to hide the backbutton provided
              title: Text("Prescriptions"),
              centerTitle: true,
            ),
            body: Column(children: <Widget>[
              SizedBox(height: 10),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Flexible(
                      child: CardWithInfoBox(
                    "Results showing from:",
                    "${DateTimeUtils.getFormattedDate(dateRange[0], fullYr: true)}-${DateTimeUtils.getFormattedDate(dateRange[1], fullYr: true)}",
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 8),
                  )),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Pick date range",
                      style: TextStyle(color: hexToColor("3b3b3b")),
                    ),
                    onPressed: () {
                      _onPressed(context);
                    },
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: prescriptions.length,
                    itemBuilder: (context, index) {
                      PrescriptionModel pres = prescriptions[index];
                      return CustomCard(
                          padding: EdgeInsets.all(12),
                          child: InkResponse(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrescriptionDetails(
                                    pres: pres,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ColumnBlock("Date", pres.createdDate,
                                        "Doctor", pres.doctorDetails["name"]),
                                    ColumnBlock("Time", pres.time,
                                        "Appointment Type", pres.doctorDetails["type"]),
                                    ColumnBlock("Expiry", pres.expiryDate,
                                        "Place", pres.hospitalDetails["city"])
                                  ],
                                ),
                                const Divider(
                                  color: Colors.blueAccent,
                                  height: 20,
                                  thickness: 1,
                                  indent: 3,
                                  endIndent: 3,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      InfoBox(
                                        "Medication",
                                        pres.medication,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        valueColor: Colors.blueAccent,
                                      ),
                                      const SizedBox(height: 20),
                                      InfoBox(
                                        "Instruction",
                                        pres.instruction,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        valueColor: Colors.blueAccent,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                    }),
              ),
            ]),
          );
        },
      ),
    );
  }
}


