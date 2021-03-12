import 'package:flutter/material.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/screens/CategoryPage.dart';
import 'package:zotivity/styles/components.dart';
import '../models/Activity.dart';
import './ActivityPage.dart';
import './GraphPage.dart';

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
        title: Text('Zotivity'),
        // backgroundColor: Colors.blue,
      ),
      drawer:CustomDrawer(),
      body: Center(
          child: Column(

        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                print('Card tapped.');
              },
              child: Container(
                width: 300,
                height: 100,
                child: Text('A card that can be tapped'),
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Search Page'),
            onPressed: () {
              // Navigator.pushNamed(context, '/searchPage');
              Navigator.push(context,
                  new MaterialPageRoute(builder: (__) => new SearchPage()));
            },
          ),
          ElevatedButton(
            child: Text('Category Page'),
            onPressed: () {
              // Navigator.pushNamed(context, '/categoryPage');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new CategoryPage(
                            // Todo: change this later
                            categoryName: "Gym",
                            futureActivityList:
                                getActivitiesByCategory("gym"),
                          )));
            },
          ),
          ElevatedButton(
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
                          futureActivity: getActivityByName("deadlift"))));
            },
          ),
          ElevatedButton(
            child: Text('Graph Page'),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (__) => new ActivityPage(activity: a)));
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (__) => new GraphPage()));
            },
          ),
          ElevatedButton(
            child: Text('debugFunction()'),
            onPressed: () {
              debugFunction();
            },
          ),
        ],
      )),
    );
  }
}
