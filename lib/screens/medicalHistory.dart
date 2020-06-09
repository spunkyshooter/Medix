import "package:flutter/material.dart";
import 'package:medix/utils/index.dart';
import 'package:medix/widgets/infoBox.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _data
                          .map((item) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InfoBox(
                                    item[0]["key"],
                                    item[0]["value"],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    valueColor: hexToColor("3b3b3b"),
                                  ),
                                  const SizedBox(height:20),
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
                     indent:3,
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
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      valueColor: Colors.blueAccent,
                    ),
                        const SizedBox(height:20),
                    InfoBox(
                      "Instruction",
                      "Take Orally before BreakFast",
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      valueColor: Colors.blueAccent,
                    ),
                  ],),)
                ],
              ));
        });
  }
}
