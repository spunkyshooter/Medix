import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medix/constants/theme.dart';
import 'package:medix/screens/authenticate/login.dart';
import 'package:medix/screens/home.dart';
import 'package:medix/screens/landing.dart';
import 'package:medix/models/UserModel.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return (ChangeNotifierProvider(
        create: (context) => UserModel(),
        child: MaterialApp(
          title: "DigiDoc",
          theme: themeData,
          home: new Wrapper(),
          initialRoute: "/",
          routes: <String, WidgetBuilder>{
            "/landing": (BuildContext context) => new Landing(),
            "/login": (BuildContext context) => new Login()
          },
        )));
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: Provider.of<UserModel>(context).user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Landing();
          } else if (snapshot.hasError) {
            return Column(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Home();
        });
  }
}
