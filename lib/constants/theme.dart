import 'package:flutter/material.dart';
import 'package:medix/utils/index.dart';

//hexToColor('0068FF') fromcard
//hexToColor('3756F5') from designer
//hexToColor('2748F7') from color picker
ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: hexToColor('2748F7') ,
  accentColor: Color(0xFFffc107),
  scaffoldBackgroundColor: hexToColor("F5F8FF"),
  textTheme: TextTheme(
    headline1: TextStyle(
        color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900),
    caption: TextStyle(
      color: hexToColor('4c9fcd'),
    ),
  ),
);

Color secondaryColor(BuildContext context) {
  return Theme.of(context).textTheme.caption.color;
}
