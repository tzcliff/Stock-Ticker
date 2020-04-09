import 'package:flutter/material.dart';
import 'package:fluttermodule/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluttermodule/constants.dart';
import 'package:fluttermodule/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermodule/services/database_service.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: TyperAnimatedTextKit(
                    speed: Duration(milliseconds: 300),
                    text: ['Stock Ticker'],
                    textStyle: kMainTextStyle),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.tealAccent.shade400,
                onPressed: () async {
                  try {
                    setState(() {
                      showSpinner = true;
                    });
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email.trim(), password: password);
                    if (newUser != null) {
                      FirebaseUser fbUser =
                          await FirebaseAuth.instance.currentUser();
                      // create a new document for the user with the uid since it's a new user
                      await DatabaseService(uid: fbUser.uid)
                          .updateWatchlistData("");
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                      showSpinner = false;
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
