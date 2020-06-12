import 'package:flutter/material.dart';
import 'package:medix/utils/index.dart';
import './infoBox.dart';

class ColumnBlock extends StatelessWidget {
  ColumnBlock(
      this.firstTitle,
      this.firstValue,
      this.secondTitle,
      this.secondValue,
      );

  final String firstTitle, firstValue, secondTitle, secondValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InfoBox(
          firstTitle,
          firstValue,
          crossAxisAlignment: CrossAxisAlignment.start,
          valueColor: hexToColor("3b3b3b"),
        ),
        const SizedBox(height: 20),
        InfoBox(
          secondTitle,
          secondValue,
          crossAxisAlignment: CrossAxisAlignment.start,
          valueColor: hexToColor("3b3b3b"),
        ),
      ],
    );
  }
}