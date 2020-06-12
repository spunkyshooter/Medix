import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medix/models/PatientModel.dart';
import 'package:medix/models/UserModel.dart';
import 'package:medix/services/Database.dart';
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
    final String uid = Provider.of<UserModel>(context).uid;

    return StreamProvider<DocumentSnapshot>.value(
      value: new DatabaseService(uid: uid).patient,
      child: Consumer<DocumentSnapshot>(
        builder: (context, document, child) {
          if (document == null) {
            return Center(child: CircularProgressIndicator());
          }
          print({"document": document.toString()});
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
                    left: 15, //same as margin in the details widget
                    child: Row(
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
              //Check whether you have temporary record stored.
              SyncDataCard(uid: user.uid)
            ],
          );
        },
      ),
    );
  }
}

class SyncDataCard extends StatefulWidget {
  SyncDataCard({this.uid});

  final String uid;

  @override
  _SyncDataCardState createState() => _SyncDataCardState();
}

class _SyncDataCardState extends State<SyncDataCard> {
  final Map<String, dynamic> state = {"loading": false, "dataExists": null};
//
//  _getDetails() {
//    setState(() {
//      state["loading"] = true;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Sync Emergency Data"), // "You have temporary record"
          RaisedButton(
            disabledColor: Colors.grey,
            color: Theme.of(context).accentColor,
            onPressed: () {},
            child: FittedBox(child: Center(child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircularProgressIndicator(backgroundColor: Colors.white,),
            ))), //"Merge Details"
          )
        ],
      ),
    );
  }
}
