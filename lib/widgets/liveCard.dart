import 'package:flutter/material.dart';
import 'package:medix/utils/index.dart';

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
              alignment: Alignment.centerRight
          ),
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
