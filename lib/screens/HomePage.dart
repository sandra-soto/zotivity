import 'package:flutter/material.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/screens/CategoryPage.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';
import '../models/Activity.dart';
import './ActivityPage.dart';
import '../models/BodyFocus.dart';
import '../models/Equipment.dart';
import '../styles/components.dart';

import 'SearchPage.dart';

class HomePage extends StatelessWidget {
  Activity a = Activity(
      "Deadlift",
      ActivityCategory.gym,
      15,
      30,
      2,
      BodyFocus.legs,
      "Deadlift Description",
      [Equipment.machine],
      "https://www.hussle.com/blog/wp-content/uploads/2020/05/Deadlift-body-change-1080x675.png",
      "resourceLink");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Row 2 UI'),
        backgroundColor: Colors.blue,
      ),
      drawer: CustomDrawer(),
      body: Center(
          child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Search Page'),
            onPressed: () {
              // Navigator.pushNamed(context, '/searchPage');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new SearchPage()));
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
                          categoryName: ActivityCategory.gym,
                          activityList: [a, a, a])));
            },
          ),
          RaisedButton(
            child: Text('Activity Page'),
            onPressed: () {
              // Navigator.pushNamed(context, '/activityPage');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new ActivityPage(activity: a)));
            },
          ),
        ],
      )),
    );
  }
}
