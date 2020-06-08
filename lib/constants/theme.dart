import 'package:flutter/material.dart';
import 'package:medix/utils/index.dart';

ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: hexToColor('3756F5'),
  accentColor: Color(0xFFffc107),
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
