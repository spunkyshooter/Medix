import 'package:flutter/material.dart';

//@params code: 6 digit
Color hexToColor(String code) {
    return Color(int.parse(code, radix: 16) + 0xFF000000);
}

Color darkenColor (Color color,double factor){
  //not took care of 255
  //BEcareful since value shoud be in range of 0-255
  int r = (color.red * factor).toInt();
  int g = (color.green * factor).toInt();
  int b = (color.blue * factor).toInt();
  double opacity = color.alpha / 255;
  Color darkShade = Color.fromRGBO(r, g, b, opacity);
  return darkShade;
}