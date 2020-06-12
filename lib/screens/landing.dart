import 'package:flutter/material.dart';
import 'package:medix/screens/MyAppointment.dart';
import 'package:medix/screens/liveData.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:medix/screens/medicalHistory.dart';
import 'package:medix/screens/profile.dart';
import 'package:medix/widgets/CustomIcons.dart';


class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<Widget> _pages = [
    LiveData(),
    MedicalHistory(),
    MyAppointment(),
    Profile(),
  ];
  int activeIdx = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(children: [
        Expanded(child: _pages[activeIdx]),
        SizedBox(
          height: 5,
          child: Container(
              color: Theme.of(context).primaryColor), //Colors.blueAccent
        )
      ]),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(CustomIcons.online_prediction, size: 30, color: Colors.black,),
          Icon(Icons.list, size: 30),
          Icon(Icons.schedule, size: 30),
          Icon(Icons.perm_identity, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            activeIdx = index;
          });
        },
      ),
    );
  }
}
