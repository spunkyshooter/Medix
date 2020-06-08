import 'package:flutter/material.dart';

//Further height and color can be customizable

class WavyBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WavyClipper(),
      child: SizedBox(
        height: 60,
        child: Container(color: Theme.of(context).primaryColor),
      ),
    );
  }
}

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = new Path();

    path.lineTo(0.0, height - 20);

    final firstControlPoint = new Offset(width / 4, 0);
    final firstEndPoint = new Offset(width / 2, height-30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint = new Offset((width / 4) * 3, height );
    final secondEndPoint = new Offset(width, 0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
