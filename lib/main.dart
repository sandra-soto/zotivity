import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:zotivity/screens/Login.dart';
import 'package:zotivity/backend/sign_in.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initAuthFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zotivity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var result = getCurrentUser();
    print("this is the user $result");
    print(result == null);
    return new SplashScreen(
        navigateAfterSeconds: result == null ? LoginPage() : FirstScreen(),
        seconds: 5,
        title: new Text(
          'Welcome $result',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        //image: Image.asset('assets/images/dart.png', fit: BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.blue);
  }

}


class BlueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(color: Colors.blue[100])
    );
  }
}

