import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:medix/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("introSeen", true);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => new Home()));
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Electronic Health Records",
          body:
              "No more meticulously going through physical documents. Its also catastrophic resistent",
          image: _buildImage('intro_4.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Assisted Technologies",
          body:
              "Manage your assisted devices on the go. Remember you own your data",
          image: _buildImage('intro_6.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Change of Ownership",
          body:
              "Worried about the doctor ? Revoke the permissions with just one click",
          image: _buildImage('intro_ehc.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "E-prescriptions",
          body:
              "Digitalized prescriptions , lab test reports and MRI scans are secured in the cloud",
          image: _buildImage('intro_3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Trusted By Millions of Doctors",
          body: "Start your beautiful journey now.",
          image: _buildImage('intro_1.png'),
          footer: RaisedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'Dive In',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
