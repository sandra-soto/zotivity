import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zotivity/screens/Login.dart';
import 'package:zotivity/backend/sign_in.dart';
import 'package:zotivity/backend/firebase.dart';

import 'package:zotivity/screens/ActivityPage.dart';
import 'package:zotivity/models/Activity.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';
import 'package:zotivity/screens/CategoryPage.dart';
import 'package:zotivity/screens/SearchPage.dart';
import 'package:zotivity/screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Todo: add persistence to user so they aren't shown the login screen if they are actually already signed in
  initAuthFirebase()
      .then((user) {
    print("Someone's already signed in: $user");
    //Todo: return the search page instead of the profile creation page if the user is already signed in
  });

  // insertExcel();
  printAllActivities();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  // Activity a = Activity(
  //     "Deadlift",
  //     ActivityCategory.gym,
  //     30,
  //     2,
  //     BodyFocus.legs,
  //     "Deadlift Description",
  //     [Equipment.gym],
  //     "https://www.hussle.com/blog/wp-content/uploads/2020/05/Deadlift-body-change-1080x675.png",
  //     "resourceLink");

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zotivity',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: LoginPage(),
      // home: ActivityPage(activity: a),
      // home: CategoryPage(categoryName: ActivityCategory.gym, activityList: [a, a, a, a]),
      // home: SearchPage(),
      // home: HomePage(),
    );
  }
}