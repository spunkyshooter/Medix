import 'package:flutter/material.dart';
import 'package:medix/widgets/CardWithInfoBox.dart';

import 'package:medix/widgets/convexBar.dart';
import 'package:medix/widgets/infoBox.dart';
import 'package:medix/widgets/stackedCurveBar.dart';

  class Profile extends StatelessWidget {
    final img ="https://media-exp1.licdn.com/dms/image/C5103AQGRxus2aqyfMw/profile-displayphoto-shrink_200_200/0?e=1597276800&v=beta&t=rDP6oqvnfI0cdPE8YSRk_FEaI1VHkvqdzzUZwe1hKlA";


    @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            Column(children: [StackedCurveBar(), ConvexBar(), SizedBox(height:20)]),
            //Image and name details
            Positioned(
              top: 40,
              left:15, //same as margin in the details widget
              child: Row(children: <Widget>[
                new Container(
                  width: 70.0,
                  height:70.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(img)
                    ),
                  ),),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text("Welcome",style:TextStyle(fontSize: 12, color: Colors.white.withOpacity(.8)) ,),
                  Text("Manoj Kumar",style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),)
                ],),
              ],),
            ),  

            //basic details
            Positioned(
              bottom: -10,
              width: MediaQuery.of(context).size.width,
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0,vertical: 12),
              margin:EdgeInsets.all(15),
              decoration: new BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(offset: Offset(0,3), blurRadius: 3, color: Colors.black.withOpacity(.1))]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InfoBox("Age","21"),
                  InfoBox("Gender","Male"),
                  InfoBox("Blood Type","A+"),
                  InfoBox("Weight","56KG"),
                  InfoBox("Height","5'10\""),
                ],),),
            )
          ],
        ),

        //email
        CardWithInfoBox("Email","manunavodaya123@gmail.com"),
        //address
        CardWithInfoBox("Address","Bengaluru, Karnataka"),
      ],
    );
  }
}





