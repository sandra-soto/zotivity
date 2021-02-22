import 'package:flutter/material.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/models/activityCategory.dart';
import '../models/Activity.dart';
import './CategoryPage.dart';

import '../models/BodyFocus.dart';
import '../models/Equipment.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Activity indoorActivity = Activity(
      "Yoga",
      ActivityCategory.indoor,
      50,
      1,
      0,
      BodyFocus.none,
      "Description for Yoga",
      [Equipment.yoga_mat],
      "https://miro.medium.com/max/11630/0*C5Y8W-6e9OVIB3AM",
      "Yoga Resource Link");
  Activity outdoorActivity = Activity(
      "Running",
      ActivityCategory.outdoor,
      40,
      0,
      1,
      BodyFocus.none,
      "Description for Running",
      [Equipment.none],
      "https://images.theconversation.com/files/327587/original/file-20200414-63518-11ajr5x.jpg?ixlib=rb-1.1.0&rect=0%2C610%2C5906%2C2953&q=45&auto=format&w=1356&h=668&fit=crop");
  Activity gymActivity = Activity(
      "Deadlift",
      ActivityCategory.gym,
      30,
      2,
      1,
      BodyFocus.legs,
      "Description for Deadlift",
      [Equipment.machine],
      "https://www.hussle.com/blog/wp-content/uploads/2020/05/Deadlift-body-change-1080x675.png",
      "Deadlift Resource Link");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(100),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Categories:",
                style: TextStyle(fontSize: 28),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => new CategoryPage(
                            categoryName: ActivityCategory.indoor,
                            futureActivityList:
                                getActivitiesByCategory("category_indoor"))));
              },
              child: Text("Indoor"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => new CategoryPage(
                            categoryName: ActivityCategory.outdoor,
                            futureActivityList:
                                getActivitiesByCategory("category_outdoor"))));
              },
              child: Text("Outdoor"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (__) => new CategoryPage(
                            categoryName: ActivityCategory.gym,
                            futureActivityList:
                                getActivitiesByCategory("category_gym"))));
              },
              child: Text("Gym"),
            ),
          ],
        ),
      ),
    );
  }
}
