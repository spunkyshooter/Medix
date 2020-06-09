import 'package:flutter/material.dart';
import 'package:medix/utils/index.dart';

class InfoBox extends StatelessWidget {
  InfoBox(this.heading, this.value,
      {this.crossAxisAlignment = CrossAxisAlignment.center,
      this.valueColor = Colors.blueAccent});

  final String heading;
  final String value;
  final Color valueColor;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: crossAxisAlignment, children: <Widget>[
      Text(
        heading,
        style: TextStyle(
          fontSize: 12,
          color: hexToColor("3b3b3b"),
        ),
      ),
      SizedBox(
        height: 12,
      ),
      Text(value,
          style: TextStyle(
              fontSize: 15, color: valueColor, fontWeight: FontWeight.w500))
    ]);
  }
}
