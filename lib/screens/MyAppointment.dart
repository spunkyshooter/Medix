import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:medix/models/Appointment.dart';
import 'package:medix/models/UserModel.dart';
import 'package:medix/services/Database.dart';
import 'package:medix/utils/index.dart';
import 'package:medix/widgets/ColumnBlock.dart';
import 'package:medix/widgets/CustomCard.dart';
import 'package:medix/widgets/infoBox.dart';
import 'package:provider/provider.dart';

class MyAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = Provider.of<UserModel>(context).uid;
    return StreamProvider<QuerySnapshot>.value(
      value: new DatabaseService(uid: uid).appointment,
      child: Consumer<QuerySnapshot>(builder: (context, data, child) {
        if (data == null) {
          return Center(child: CircularProgressIndicator());
        }
        List<AppointmentModel> appointments =
            DatabaseService.appointmentModelsFromSnapShot(data);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "My Appointment",
                style: TextStyle(
                  color: hexToColor("3b3b3b"),
                ),
              ),
              bottom: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: hexToColor("3b3b3b"),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.schedule),
                    text: "Upcoming",
                  ),
                  Tab(
                    icon: Icon(Icons.timeline),
                    text: "Past",
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              Appointments(
                isUpcoming: true,
                appointments: appointments.where((el) => el.upcoming).toList(),
              ),
              Appointments(
                  isUpcoming: false,
                  appointments:
                      appointments.where((el) => !el.upcoming).toList()),
            ]),
          ),
        );
      }),
    );
  }
}

class Appointments extends StatelessWidget {
  Appointments({this.appointments, this.isUpcoming});

  final List<AppointmentModel> appointments;
  final bool isUpcoming;

  final Color reddish = hexToColor("E95150");

  Widget _btn(BuildContext context, String documentId) => RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: reddish,
        onPressed: () async {
          //add status field
          await DatabaseService().cancelAppointment(documentId);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Cancelled",
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          AppointmentModel appointment = appointments[index];
          return CustomCard(
            padding: EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ColumnBlock(
                          "Date",
                          appointment.date,
                          "Appointment Type",
                          appointment.doctor["type"],
                        ),
                        ColumnBlock(
                          "Time",
                          appointment.time,
                          "Place",
                          appointment.doctor["city"],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InfoBox(
                              "Doctor",
                              "Dr.Bob",
                              crossAxisAlignment: CrossAxisAlignment.start,
                              valueColor: hexToColor("3b3b3b"),
                            ),
                            const SizedBox(height: 20),
                            isUpcoming //if upcoming the show cancel btn
                                ? _btn(context, appointment.id)
                                : InfoBox(
                                    //Else show status
                                    "Status",
                                    appointment.cancelled
                                        ? "Cancelled"
                                        : "Completed",
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    valueColor: appointment.cancelled
                                        ? reddish
                                        : Colors.green,
                                  ),
                          ],
                        ),
                      ]),
                ]),
          );
        });
  }
}
