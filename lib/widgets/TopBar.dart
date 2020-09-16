import 'package:flutter/material.dart';
import 'package:medix/widgets/stackedCurveBar.dart';
import 'package:medix/widgets/wavyBar.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
    @required this.titleStyle,
  }) : super(key: key);

  final TextStyle titleStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(children: [StackedCurveBar(), WavyBar()]),
        Positioned(
          right: 20,
          top: 80,
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: 'MEDI',
                style: titleStyle.copyWith(color: Colors.white),
              ),
              TextSpan(
                text: 'X',
                style: titleStyle.copyWith(
                  color: Theme.of(context).accentColor,
                ),
              )
            ]),
          ),
        ),
        Positioned(
          left: 10,
          top: 100,
          child: Row(children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white.withAlpha(128),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Sign In",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ]),
        )
      ],
    );
  }
}
