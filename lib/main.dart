import 'package:flutter/material.dart';
import 'package:medix/constants/theme.dart';
import 'package:medix/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'Medix',
    options: const FirebaseOptions(
      googleAppID: '1:657821873154:android:196d8031d0458768bd231b',
      apiKey: 'AIzaSyBVcVnw3mDcUNPDvl4iLphFdHyH0VjuMUg',
      projectID: 'medix-279619',
    ),
  );
  final Firestore firestore = Firestore(app: app);

  runApp(MyApp(firestore: firestore));
}

class MyApp extends StatelessWidget {
  MyApp({this.firestore});
  final Firestore firestore;

  Widget build(BuildContext context) {
    return (MaterialApp(
      title: "DigiDoc",
      theme: themeData,
      home: new Home(),
    ));
  }
}
