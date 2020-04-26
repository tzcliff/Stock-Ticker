import 'package:flutter/material.dart';
import 'package:fluttermodule/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermodule/screens/welcome_screen.dart';
import 'home_screen.dart';
import 'package:fluttermodule/components/rounded_button.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
            SizedBox(
              width: 10,
            ),
            Text('${HomeScreen.email}', style: kPriceTextStyle),
          ],
        ),
        RoundedButton(
            color: Colors.tealAccent.shade400,
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamed(context, WelcomeScreen.id);
            },
            title: 'Sign Out'),
      ],
    );
  }
}
