import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medix/models/UserModel.dart';
import 'package:medix/screens/MyAppointment.dart';
import 'package:medix/screens/liveData.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:medix/screens/medicalHistory.dart';
import 'package:medix/screens/profile.dart';
import 'package:medix/services/Database.dart';
import 'package:medix/widgets/CustomIcons.dart';
import 'package:provider/provider.dart';

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

  Widget profileIcon(bool requestsPresent) {
    return requestsPresent
        ? Center(
            child: Badge(
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                '1',
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(Icons.perm_identity, size: 30),
            ),
          )
        : Icon(Icons.perm_identity, size: 30);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if (user == null || user.uid == null) {
      return Center(child: CircularProgressIndicator());
    }
    final String uid = user.uid;
    return StreamProvider<DocumentSnapshot>.value(
      value: DatabaseService(uid: uid).requests,
      child: Consumer<DocumentSnapshot>(builder: (context, document, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(children: [
            Expanded(child: _pages[activeIdx]),
            SizedBox(
              height: 5,
              child: Container(
                  color: Theme.of(context).primaryColor), //Colors.blueAccent
            ),
          ]),
          bottomNavigationBar: new CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 50.0,
            items: <Widget>[
              Icon(
                CustomIcons.online_prediction,
                size: 30,
                color: Colors.black,
              ),
              Icon(Icons.list, size: 30),
              Icon(Icons.schedule, size: 30),
              profileIcon(document != null &&
                  document.data != null &&
                  document.data["accepted"] == -1),
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
      }),
    );
  }
}
