import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:medix/screens/liveData.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<Widget> _pages = [
    LiveData(),
    Text("Prescription"),
    Text("ProfilePage")
  ];
  int activeIdx = 1;
// Container(
//           child: Center(
//             child: _pages[activeIdx],
//           ),
//         )
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiveData(),
        bottomNavigationBar: ConvexAppBar(
          activeColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            TabItem(icon: Icons.home, title: 'Monitor'),
            TabItem(icon: Icons.add, title: 'History'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: activeIdx, //optional, default as 0
          onTap: (int i) {
            setState(() {
              activeIdx = i;
            });
          },
        ));
  }
}
