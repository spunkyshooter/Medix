import 'package:flutter/material.dart';
import 'package:medix/screens/authenticate/login.dart';

class Home extends StatelessWidget {
  final doctorImg = 'assets/images/doc.png';
  final violetColor = Color(0xFFA700FF);

  BoxDecoration _decoration(context) => BoxDecoration(
      // gradient: LinearGradient(
      //   colors: [violetColor, Theme.of(context).primaryColor],
      //   begin: Alignment(-1.0, -1.0),
      //   end: Alignment(1.0, 1.0),
      // ),
      color: Theme.of(context).primaryColor);
  final colorWhite = TextStyle(color: Colors.white);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        //wrapped in container, because we want gradient
        decoration: _decoration(context),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  //placing inside the container, because we wanna place  buttons at bottom, hence making this into a component
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        doctorImg,
                        width: 200,
                      ),
                      Text(
                        "Welcome !",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      Text(
                        "We care for you",
                        style: colorWhite.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button(
                            title: "Sign In",
                            textColor: Color(0xFF1B14AA),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            }),
                        Button(
                            title: "Sign Up",
                            textColor: Color(0xFF1B14AA),
                            onPressed: () {}),
                      ],
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

//buttin for the login/signUp
//@params title: text to display inside flat button
class Button extends StatelessWidget {
  final String title;
  final Color textColor;
  final Function onPressed;
  Button({this.title, this.textColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70.0),
      child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          color: Colors.white,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(32.0),
          ),
          child: Text(title,
              style: (textColor != null) ? TextStyle(color: textColor) : '')),
    );
  }
}
