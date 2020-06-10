import 'package:flutter/material.dart';
import 'package:medix/widgets/infoBox.dart';

class CardWithInfoBox extends StatelessWidget {
  CardWithInfoBox(this.title, this.value, {this.width, this.padding});

  final String title;
  final String value;
  final double width;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    double _width = width ?? MediaQuery.of(context).size.width;
    return Container(
      width: _width,
      padding:
          padding ?? EdgeInsets.only(left: 20, top: 12, bottom: 12, right: 20),
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
      child: InfoBox(
        title,
        value,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
