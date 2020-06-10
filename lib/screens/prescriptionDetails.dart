import 'package:flutter/material.dart';
import 'package:medix/utils/index.dart';
import 'package:medix/widgets/CardWithInfoBox.dart';
import 'package:medix/widgets/convexBar.dart';

class PrescriptionDetails extends StatelessWidget {
  PrescriptionDetails({@required this.data});

  final List<List<Map<String, String>>> data;

  @override
  Widget build(BuildContext context) {
    //reshaping the data as needed
    List<Map<String, String>> _data = [];
    _data.add({"key": "Hospital", "value": "KMS Hospital"});
    _data.add({"key": "Address", "value": "Bengaluru, Karnataka"});

    for (int i = 0; i < data.length; ++i) {
      _data.add(data[i][0]);
    }
    for (int i = 0; i < data.length; ++i) {
      _data.add(data[i][1]);
    }

    Size size = MediaQuery.of(context).size;
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
          children: _data
              .map((item) => CardWithInfoBox(item["key"], item["value"]))
              .toList(),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
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
