// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:medix/services/auth.dart';

/// Mix-in DiagnosticableTreeMixin to have access to debugFillProperties for the devtool
class UserModel with ChangeNotifier, DiagnosticableTreeMixin {
  String _uid;
  FirebaseUser _user;
  String get uid => _uid;

  AuthService _auth = new AuthService();

  //we are consuming here first,
  //by using defining this function, we don't need to use
  // Provider.of<UserModel>(context,listen: false).uid = snapshot.data.uid;
  // inside Future Builder
  Future<FirebaseUser> get user async {
     _user = await _auth.getUser; //syncing with this model
     _uid = _user != null ? _user.uid : _uid;
    return _user;
  }

   set uid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('uid', _uid));
  }
}
