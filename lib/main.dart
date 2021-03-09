import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/screens/Login.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:zotivity/screens/HomePage.dart';
import 'package:zotivity/backend/sign_in.dart';
import 'package:get/get.dart';
import 'package:zotivity/screens/ProfileCreation.dart';

import 'backend/mongo.dart';







void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
      theme: ThemeData(   // https://brand.uci.edu/brand-assets/color-palette/
        primaryColor: const Color.fromRGBO(27, 61, 109, 1),
        accentColor: const Color.fromRGBO(255, 210, 0, 1),
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 28,
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: const Color.fromRGBO(255, 210, 0, 1),
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              // fontFamily: FontNameDefault,
              fontSize: 24,
              color: const Color.fromRGBO(255, 210, 0, 1)
            )
          )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData (
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(27, 61, 109, 1),
            onPrimary: const Color.fromRGBO(255, 210, 0, 1),
          )
        )
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
          style: Theme.of(context).textTheme.headline1,
        ),
        //image: Image.asset('assets/images/dart.png', fit: BoxFit.scaleDown),
        backgroundColor: Theme.of(context).primaryColor,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.blue);
  }

}




