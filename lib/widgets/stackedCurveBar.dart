import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medix/utils/index.dart';

class StackedCurveBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 150,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              height: 150,
              color: hexToColor('2142F1'),
            ),
            clipper: StakedChildClipper(),
          )
        ],
      ),
    );
  }
}

class StakedChildClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = new Path();
    //creating the path, starts from 0.0,0.0 (top left corner)
    path.lineTo(0.0, height - 10); //to directly below

    //for creating the curve, we need control point and end point

    var firstControlPoint = new Offset(width / 4, height - 10);
    var firstEndPoint = new Offset(width / 3, height / 2);
    //creating a 2-d cartesan point (could have been given directly below),
    //still prefers clean code !
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = new Offset(width / 3 + 30, 20);
    var secondEndPoint = new Offset(width * (2 / 3) + 8, 0.0);
    //creating a 2-d cartesan point (could have been given directly below),
    //still prefers clean code !
    path.quadraticBezierTo( secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
