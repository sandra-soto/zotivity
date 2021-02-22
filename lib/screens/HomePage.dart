import 'package:flutter/material.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/screens/CategoryPage.dart';
import '../models/Activity.dart';
import './ActivityPage.dart';

import '../models/BodyFocus.dart';
import '../models/Equipment.dart';
import 'SearchPage.dart';
import '../backend/firebase.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Row 2 UI'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Search Page'),
            onPressed: () {
              // Navigator.pushNamed(context, '/searchPage');
              Navigator.push(context,
                  new MaterialPageRoute(builder: (__) => new SearchPage()));
            },
          ),
          RaisedButton(
            child: Text('Category Page'),
            onPressed: () {
              // Navigator.pushNamed(context, '/categoryPage');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new CategoryPage(
                            // Todo: change this later
                            categoryName: ActivityCategory.category_gym,
                            futureActivityList:
                                getActivitiesByCategory("category_gym"),
                          )));
            },
          ),
          RaisedButton(
            child: Text('Activity Page'),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (__) => new ActivityPage(activity: a)));
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new ActivityPage(
                          futureActivity: getActivityByName("Deadlift"))));
            },
          ),
          // RaisedButton(
          //   child: Text('testFunction()'),
          //   onPressed: () {
          //     testFunction();
          //   },
          // ),
        ],
      )),
    );
  }
}
