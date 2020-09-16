import 'package:medix/services/auth.dart';
import 'package:medix/widgets/BtnWithSnackBar.dart';
import 'package:medix/widgets/TopBar.dart';
import 'package:medix/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:medix/widgets/MedixTextFormField.dart';

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
  final Map<String, dynamic> state = {
    "email": null,
    "password": null,
    "loading": false
  };

  onChange(id, text) {
    setState(() {
      state[id] = text;
    });
  }

  _handleSignIn(BuildContext context) async {
    setState(() {
      state["loading"] = true;
    });
    dynamic response =
        await _auth.signInWithEmailAndPass(state["email"], state["password"]);

    setState(() {
      state["loading"] = false;
    });
    print("login");
    print(response.toString());

    if (response["success"] == false) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text(
              response["error"],
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).primaryColor),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: hexToColor("fafafa"),
      body: Column(
        children: <Widget>[
          new TopBar(titleStyle: titleStyle),
          new MedixTextFormField(
            id: 'email',
            onChange: onChange,
            labelText: "Email",
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(
              Icons.email,
              color: Colors.blueAccent,
            ),
          ),
          new MedixTextFormField(
            id: 'password',
            onChange: onChange,
            labelText: "Password",
            obscureText: true,
            prefixIcon: Icon(
              Icons.vpn_key,
              color: Colors.blueAccent,
            ),
          ),
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
                BtnWithSnackBar(
                  onPressed: _handleSignIn,
                  loading: state["loading"],
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, "/register");
            },
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "Don't have account?  ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: "Register",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
