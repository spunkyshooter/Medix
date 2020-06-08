import 'package:flutter/material.dart';
import 'package:medix/utils/index.dart';

class LiveData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical:10),
            child: Text("How is your Health?",
            style: TextStyle(color:hexToColor("000000"),fontSize: 18, fontWeight: FontWeight.w500),
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

class LiveCard extends StatelessWidget {
  LiveCard(this.title, this.value, this.unit, this.status,
      {this.color, this.bgClr, this.img});
  final String title;
  final String value;
  final String status;
  final String unit;
  final Color color;
  final String bgClr;
  final String img;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: hexToColor(bgClr),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 4),
              color: Colors.black12,
            )
          ],
          borderRadius: BorderRadius.circular(30),
          image: new DecorationImage(
              image: new AssetImage('assets/images/$img'),
              alignment: Alignment.centerRight),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color.withAlpha(240),
                  fontSize: 14,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: value,
                      style: TextStyle(
                          color: color,
                          fontSize: 32,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(text: "  "),
                    TextSpan(
                      text: unit,
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                ),
              ),
            ]),
      ),
    );
  }
}
