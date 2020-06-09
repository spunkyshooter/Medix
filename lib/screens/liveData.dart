import 'package:flutter/material.dart';
import 'package:medix/utils/index.dart';
import 'package:medix/widgets/liveCard.dart';

class LiveData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            "72",
            "bpm",
            "Normal",
            color: Colors.black,
            bgClr: "FADB39",
            img: "heart2.png",
          ),
          LiveCard(
            "Respiratory Rate",
            "12-20",
            "Bpm",
            "Normal",
            color: Colors.white,
            bgClr: "0085FF", //"0068FF",
            img: "lung.png",
          ),
          LiveCard(
            "Blood Pressure",
            "120/80",
            "mmHg",
            "Normal",
            color: Colors.white,
            bgClr: "FE6363",
            img: "bloodPressure.png",
          ),
          LiveCard(
            "Moveable",
            "Yes",
            "",
            "Normal",
            color: Colors.black,
            bgClr: "FFFFFF", //"27A3AB"  greenish
            img: "moveable.png",
          ),
        ],
      ),
    );
  }
}
