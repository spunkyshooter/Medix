import 'package:flutter/material.dart';

//Further height and color can be customizable

class ConvexBar extends StatelessWidget {
  ConvexBar({this.height = 30, this.color, this.child});

  final double height;
  final Widget child;
  Color color;

  @override
  Widget build(BuildContext context) {
    color = color ?? Theme.of(context).primaryColor;
    return ClipPath(
      clipper: WavyClipper(),
      child: child != null
          ? child
          : SizedBox(
              height: height,
              child: Container(color: color), //Theme.of(context).primaryColor
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

    path.lineTo(0.0, 0.0);

    final controlPoint = new Offset(width / 2, height);
    final endPoint = new Offset(width, 0);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
