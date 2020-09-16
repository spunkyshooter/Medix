import 'package:firebase_auth/firebase_auth.dart';
import 'package:medix/services/auth.dart';

class UserModel {
  String uid;
  FirebaseUser user;

  UserModel({user})
      : this.user = user,
        this.uid = user?.uid;
}
