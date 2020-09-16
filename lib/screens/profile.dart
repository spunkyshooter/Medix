import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medix/models/PatientModel.dart';
import 'package:medix/models/UserModel.dart';
import 'package:medix/services/Database.dart';
import 'package:medix/services/auth.dart';
import 'package:medix/widgets/CardWithInfoBox.dart';
import 'package:medix/widgets/CustomCard.dart';

import 'package:medix/widgets/convexBar.dart';
import 'package:medix/widgets/infoBox.dart';
import 'package:medix/widgets/stackedCurveBar.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final img =
      "https://media-exp1.licdn.com/dms/image/C5103AQGRxus2aqyfMw/profile-displayphoto-shrink_200_200/0?e=1597276800&v=beta&t=rDP6oqvnfI0cdPE8YSRk_FEaI1VHkvqdzzUZwe1hKlA";

  @override
  Widget build(BuildContext context) {
    print("profile page");
    final String uid = Provider.of<FirebaseUser>(context).uid;

    var _requestsProvider = Provider.of<DocumentSnapshot>(context);
    if (_requestsProvider == null) {
      return Center(child: CircularProgressIndicator());
    }
    Map<String, dynamic> _requests = _requestsProvider.data;
    return StreamProvider<DocumentSnapshot>.value(
      value: new DatabaseService(uid: uid).patient,
      child: Consumer<DocumentSnapshot>(
        builder: (context, document, child) {
          if (document == null) {
            return Center(child: CircularProgressIndicator());
          }
          final PatientModel user = PatientModel.fromJson(document.data);
          return ListView(
            children: <Widget>[
              Stack(
                overflow: Overflow.clip,
                children: <Widget>[
                  Column(children: [
                    StackedCurveBar(),
                    ConvexBar(),
                    SizedBox(height: 20)
                  ]),
                  //Image and name details
                  Positioned(
                    top: 40,
                    left: 15,
                    right: 15, //same as margin in the details widget
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill, image: new NetworkImage(img)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(.8)),
                            ),
                            Text(
                              user.name,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(color: Colors.redAccent),
                        ),
                        //please take all the available space, since flutter doesn't have margin auto
                        FlatButton(
                          textColor: Colors.white,
                          onPressed: () {
                            new AuthService().signOut();
                          },
                          child: Row(
                            children: <Widget>[
                              Text("Logout "),
                              Icon(Icons.exit_to_app)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //basic details
                  Positioned(
                    bottom: -10,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                      margin: EdgeInsets.all(15),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(.1))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InfoBox("Age", user.age),
                          InfoBox("Gender", user.gender),
                          InfoBox("Blood Type", user.bloodGroup),
                          InfoBox("Weight", "56KG"),
                          InfoBox("Height", "5'10\""),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              //email
              CardWithInfoBox("Email", user.email),
              //address
              CardWithInfoBox("Address", user.address),
              //Requests
              _requests != null && _requests["accepted"] == -1
                  ? RequestBox(requests: _requests)
                  : SizedBox(height: 0),
            ],
          );
        },
      ),
    );
  }
}

class RequestBox extends StatelessWidget {
  RequestBox({this.requests});

  final Map<String, dynamic> requests;

  Function setRequest(BuildContext context, String uid, int value) {
    DatabaseService(uid: uid).acceptOrDeclineRequest(value);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value == 1 ? "Accepted" : "Declined",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  // new DatabaseService(uid: uid).acceptOrDeclineRequest(1);
  Widget btn(Color color, String text, Function onPressed) {
    return OutlineButton(
      textColor: color,
      disabledTextColor: Colors.white,
      borderSide: BorderSide(
        color: color,
      ),
      highlightColor: color.withOpacity(.1),
      highlightedBorderColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: color,
      onPressed: onPressed,
      child: Center(child: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<UserModel>(context).uid;
    return CustomCard(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Grant Permissions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          InfoBox(
            "Doctor",
            requests["doctorName"],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBox(height: 10),
          InfoBox(
            "Reason",
            requests["message"],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              btn(Colors.green, "Accept ✔", () {
                setRequest(context, uid, 1);
              }),
              btn(Colors.red, "Decline ❌", () {
                setRequest(context, uid, 0);
              }),
            ],
          )
        ],
      ),
    );
  }
}
