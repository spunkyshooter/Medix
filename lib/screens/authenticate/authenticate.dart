import 'package:flutter/material.dart';
import 'package:medix/models/UserModel.dart';
import 'package:medix/screens/authenticate/login.dart';
import 'package:provider/provider.dart';

/*NOT USED YET*/
//wrapping provider widget for
class Authenticate extends StatefulWidget {
  Authenticate({this.isSignIn});
  final bool isSignIn;

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: widget.isSignIn ? Login() : Container(), //TODO:register
    );
  }
}
