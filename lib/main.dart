import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/screens/Login.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:zotivity/screens/HomePage.dart';
import 'package:zotivity/backend/sign_in.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:get/get.dart';
import 'package:zotivity/screens/ProfileCreation.dart';

import 'backend/mongo.dart';







void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // insertExcel();

  print("im so fucking confused");
  await initMongoDB();
  initNotifs();
  requestIOSPermissions();
  await initAuthFirebase();
  await initLocalStorage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
    if (result != null){
      signInWithGoogleSilently().then((user) {
        getMongoUser();
      });


    }

    return new SplashScreen(
      //Todo: change later
        navigateAfterSeconds: result == null ? LoginPage() : HomePage(),
      //navigateAfterSeconds: FirstScreen(),
        seconds: 5,
        title: result == null? new Text('') : new Text(
          'Welcome, ${result.displayName}',
          style: TextStyle(fontSize: 20.0),
        ),
        //image: Image.asset('assets/images/dart.png', fit: BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.blue);
  }

}




