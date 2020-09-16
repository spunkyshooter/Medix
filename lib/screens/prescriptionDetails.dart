import 'package:flutter/material.dart';
import 'package:medix/models/percription.dart';
import 'package:medix/utils/index.dart';
import 'package:medix/widgets/CardWithInfoBox.dart';
import 'package:medix/widgets/CustomCard.dart';
import 'package:medix/widgets/convexBar.dart';

class PrescriptionDetails extends StatelessWidget {
  PrescriptionDetails({@required this.pres});

  final PrescriptionModel pres;

  List<Map<String, String>> _getFormattedList() {
    //reshaping the data as needed
    List<Map<String, String>> _data = [];
    _data.add({"key": "Hospital", "value": pres.hospitalDetails["name"]});
    _data.add({"key": "Address", "value": pres.hospitalDetails["city"]});
    _data.add({"key": "Doctor", "value": pres.doctorDetails["name"]});
    _data.add({"key": "Appointment Type", "value": pres.doctorDetails["type"]});
    _data.add({"key": "Date", "value": pres.createdDate});
    _data.add({"key": "Time", "value": pres.time});
    _data.add({"key": "Expiry", "value": pres.expiryDate});
    _data.add({"key": "Disease", "value": pres.disease.join(", ")});
    _data.add({"key": "Symptoms", "value": pres.symptoms.join(", ")});
    _data.add({"key": "Medication", "value": pres.medication});
    _data.add({"key": "Instruction", "value": pres.instruction});

    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
        backgroundColor: hexToColor("39A1FF"), //hexToColor("FFAF02"),
        elevation: 0.5,
      ),
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(children: <Widget>[
        Image.asset(
          "assets/images/hospital-cropped.jpg", //-yellow
        ),
        ConvexBar(
          color: hexToColor("39A1FF"),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getFormattedList()
              .map((item) => CardWithInfoBox(item["key"], item["value"]))
              .toList(),
        ),
        //FILES
        CustomCard(
          padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "  Files",
                style: TextStyle(
                  fontSize: 12,
                  color: hexToColor("3b3b3b"),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/backPain.jpg"),
                      )),
                      margin: EdgeInsets.all(5),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
