import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zotivity/screens/Login.dart';
import 'package:zotivity/backend/sign_in.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Todo: add persistence to user so they aren't shown the login screen if they are actually already signed in
  initAuthFirebase()
      .then((user) {
    print("Someone's already signed in: $user");
    //Todo: return the search page instead of the profile creation page if the user is already signed in
  });

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zotivity',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: LoginPage(),
    );
  }
}