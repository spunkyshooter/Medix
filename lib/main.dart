import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medix/constants/theme.dart';
import 'package:medix/screens/authenticate/login.dart';
import 'package:medix/screens/authenticate/register.dart';
import 'package:medix/screens/home.dart';
import 'package:medix/screens/introScreen.dart';
import 'package:medix/screens/landing.dart';
import 'package:medix/models/UserModel.dart';
import 'package:medix/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<bool> _isIntroSeen() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
//    return _prefs.getBool('introSeen') ?? false;
    return false;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Medix",
      theme: themeData,
      home: StreamProvider<FirebaseUser>.value(
        value: FirebaseAuth.instance.onAuthStateChanged,
        child: Consumer<FirebaseUser>(builder: (context, data, child) {
//          //TO remove currentUser for testing
//          if (data != null) {
//            new AuthService().signOut();
//          }
          print("main page");
          print(data != null && data.uid != null);
          return data != null && data.uid != null
              ? Landing()
              : FutureBuilder<bool>(
                  future: _isIntroSeen(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data == true
                          ? new Home()
                          : new OnBoardingPage();
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return new Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        color: Colors.amber,
                      );
                    }
                  },
                );
//          Home();
        }),
      ),
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/landing": (BuildContext context) => new Landing(),
        "/login": (BuildContext context) => new Login(),
        "/register": (BuildContext context) => new Register(),
      },
    );
  }
}
