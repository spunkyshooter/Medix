import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.child, this.width, this.padding});

  final Widget child;
  final double width;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
      child: child,
    );
  }
}
