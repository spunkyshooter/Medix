import 'package:medix/screens/landing.dart';
import 'package:medix/services/auth.dart';
import 'package:medix/widgets/TopBar.dart';
import 'package:medix/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:medix/constants/theme.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  TextStyle titleStyle = TextStyle(
    letterSpacing: 4.0,
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );
  final Map<String, dynamic> state = {"email": null, "password": null};

  onChange(id, text) {
    setState(() {
      state[id] = text;
    });
  }

  _handleSignIn(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Landing(),
        ));
    /*
    dynamic response = await _auth.signInWithEmailAndPass(
        state["email"], state["password"]);
    if (response["success"] == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Landing(),
          ));
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text(
              response["error"],
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).primaryColor),
      );
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: hexToColor("fafafa"),
      body: Column(
        children: <Widget>[
          new TopBar(titleStyle: titleStyle),
          new MyTextField(
              id: 'email', onChange: onChange, hintText: "Email"),
          new SizedBox(height: 10), //some space
          new MyTextField(
              id: 'password', onChange: onChange, hintText: "Password"),
          Align(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 14.0),
                child: new Text("Forgot your password?"),
              ),
              alignment: Alignment.centerRight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Sign In'),
                  BtnWithSnackbar(onPressed: _handleSignIn),
                ]),
          ),
          RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Don't have account?  ",
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                text: "Register",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final Function onChange;
  final String hintText;
  final String id;
  const MyTextField({
    this.id,
    this.onChange,
    this.hintText,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _secondaryColor = secondaryColor(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: _secondaryColor),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _secondaryColor)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
        onChanged: (text) {
          onChange(id, text);
        },
      ),
    );
  }
}

class BtnWithSnackbar extends StatelessWidget {
  BtnWithSnackbar({this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Icon(
        Icons.arrow_forward,
        // color: Colors.black,
      ),
      onPressed: () {
        onPressed(context);
      },
    );
  }
}
