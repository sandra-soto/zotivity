import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zotivity/backend/mongo.dart';
import 'package:zotivity/models/ZotUser.dart';
import 'package:zotivity/screens/HomePage.dart';
import 'package:zotivity/backend/sign_in.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/screens/ProfileCreation.dart';
import 'package:zotivity/styles/components.dart';
import '../backend/sign_in.dart';



// UI for login screen, alrady connected to backend
// should be imported
// call LoginPage() in the MyApp function
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(29, 40, 56, 1),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Zotivity", style: TextStyle(fontSize: 50)),
              Text("Finding time to exercise", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
              SizedBox(height: 50),
              _signInButton(context),
            ],
          ),
        ),
      ),
    );
  }


}

// Todo: find a better way to connect screens lol
Widget _signInButton(BuildContext context) {
  return OutlineButton(
    splashColor: Colors.blue,
    onPressed: () {

     signInWithGoogle().then((user){

        getMongoUser().then((result_2) {
          print("the google user $user");
          if (user != null) {
            print(user);

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            currentZotUser == null ? ProfileCreation(googleInfo: user) : HomePage()), (Route<dynamic> route) => false);

          }
        });
      });


      },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.blue),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FaIcon(FontAwesomeIcons.google),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}


