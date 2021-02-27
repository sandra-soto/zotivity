import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zotivity/models/ZotUser.dart';
import 'package:zotivity/screens/HomePage.dart';
import 'package:zotivity/backend/sign_in.dart';
import 'package:zotivity/backend/globals.dart';
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
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
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
    splashColor: Colors.grey,
    onPressed: () {
      signInWithGoogle().then((user) {
        if (user != null) {

          currentUserEmail = user.email;
          var storedUser = localStorage.get(currentUserEmail);
          if (storedUser != null){
            currentUser = ZotUser.fromJson(jsonDecode(storedUser));
            print("Retrieved user from local storage: $currentUser");
          }


          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        }
      });
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
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



// TODO: remove this later, only for testing
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zotivity'),
      ),
      drawer: CustomDrawer(),
      body: Container(color: Colors.white)
//      body: new MaterialButton(
//          color: Colors.blue,
//          onPressed: () async {
//            final List<DateTime> picked = await DateRagePicker.showDatePicker(
//                context: context,
//                initialFirstDate: new DateTime.now(),
//                initialLastDate: (new DateTime.now().add(new Duration(days: 10))),
//                firstDate: new DateTime(2015),
//                lastDate: new DateTime(2022)
//            );
//            if (picked != null && picked.length == 2) {
//              print(picked);
//
//            }
//          },
//          child: new Text("Pick date range")
//      )
    );

  }
}