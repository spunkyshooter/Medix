import "package:flutter/material.dart";
import 'package:medix/screens/prescriptionDetails.dart';
import 'package:medix/utils/index.dart';
import 'package:medix/widgets/CardWithInfoBox.dart';
import 'package:medix/widgets/infoBox.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class MedicalHistory extends StatelessWidget {
  final List<List<Map<String, String>>> _data = [
    [
      {"key": "Date", "value": "03 Aug 2020"},
      {"key": "Doctor", "value": "Dr. Alice"}
    ],
    [
      {"key": "Time", "value": "1:20PM"},
      {"key": "Appointment Type", "value": "Orthopaedic"}
    ],
    [
      {"key": "Expiry", "value": "03 Sept 2020"},
      {"key": "Place", "value": "Bengaluru"}
    ],
  ];

  _onPressed(BuildContext context) async {
    final dateResult = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: DateTime.now(),
      initialLastDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (dateResult != null && dateResult.length == 2) {
      print(dateResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //to hide the backbutton provided
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
              "2 Jun 2020 - 4 Jun 2020",
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    margin: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(.1))
                        ]),
                    child: InkResponse(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PrescriptionDetails(data: _data),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: _data
                                  .map((item) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          InfoBox(
                                            item[0]["key"],
                                            item[0]["value"],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            valueColor: hexToColor("3b3b3b"),
                                          ),
                                          const SizedBox(height: 20),
                                          InfoBox(
                                            item[1]["key"],
                                            item[1]["value"],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            valueColor: hexToColor("3b3b3b"),
                                          ),
                                        ],
                                      ))
                                  .toList()),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InfoBox(
                                  "Medication",
                                  "100mg Paracetemol",
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  valueColor: Colors.blueAccent,
                                ),
                                const SizedBox(height: 20),
                                InfoBox(
                                  "Instruction",
                                  "Take Orally before BreakFast",
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
  }
}

/*
Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 12, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Results showing from:",
                textAlign: TextAlign.left,
              ),
              Text(
                "2 Jun 2020 - 4 Jun 2020",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.blueAccent),
              )
            ],
          ),
        ),
* */
