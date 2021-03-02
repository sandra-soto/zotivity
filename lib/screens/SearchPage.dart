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
      BodyFocus.legs,
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
      BodyFocus.legs,
      "Description for Running",
      List<Equipment>(),
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
        margin: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Categories:",
                  style: TextStyle(fontSize: 28),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Category: Indoor",
                                  futureActivityList:
                                      getActivitiesByCategory("indoor"))));
                    },
                    child: Text("Indoor"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Category: Outdoor",
                                  futureActivityList:
                                      getActivitiesByCategory("outdoor"))));
                    },
                    child: Text("Outdoor"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Category: Gym",
                                  futureActivityList:
                                      getActivitiesByCategory("gym"))));
                    },
                    child: Text("Gym"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Body Focus:",
                  style: TextStyle(fontSize: 28),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Body Focus: Arms",
                                  futureActivityList:
                                      queryActivityList("focus", "arms"))));
                    },
                    child: Text("Arms"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Body Focus: Chest",
                                  futureActivityList:
                                      queryActivityList("focus", "chest"))));
                    },
                    child: Text("Chest"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Body Focus: Shoulders",
                                  futureActivityList: queryActivityList(
                                      "focus", "shoulders"))));
                    },
                    child: Text("Shoulders"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Body Focus: Torso",
                                  futureActivityList:
                                      queryActivityList("focus", "torso"))));
                    },
                    child: Text("Torso"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Body Focus: Back",
                                  futureActivityList:
                                      queryActivityList("focus", "back"))));
                    },
                    child: Text("Back"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Body Focus: Glutes",
                                  futureActivityList:
                                      queryActivityList("focus", "glutes"))));
                    },
                    child: Text("Glutes"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Body Focus: Legs",
                                  futureActivityList:
                                      queryActivityList("focus", "legs"))));
                    },
                    child: Text("Legs"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Body Focus: Full",
                                  futureActivityList:
                                      queryActivityList("focus", "full"))));
                    },
                    child: Text("Full"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Body Focus: None",
                                  futureActivityList:
                                      queryActivityList("focus", ""))));
                    },
                    child: Text("None"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Equipment:",
                  style: TextStyle(fontSize: 28),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Equipment: Bike",
                                  futureActivityList:
                                      queryActivityList("equipment", "bike"))));
                    },
                    child: Text("Bike"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Equipment: Dumbbells",
                                  futureActivityList: queryActivityList(
                                      "equipment", "dumbbells"))));
                    },
                    child: Text("Dumbbells"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Equipment: Barbell",
                                  futureActivityList: queryActivityList(
                                      "equipment", "barbell"))));
                    },
                    child: Text("Barbell"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Equipment: Resistance Bands",
                                  futureActivityList: queryActivityList(
                                      "equipment", "resistance bands"))));
                    },
                    child: Text("Resistance Band"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Equipment: Pullup Bar",
                                  futureActivityList: queryActivityList(
                                      "equipment", "pull up bar"))));
                    },
                    child: Text("Pullup Bar"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Equipment: Yoga Mat",
                                  futureActivityList: queryActivityList(
                                      "equipment", "yoga mat"))));
                    },
                    child: Text("Yoga Mat"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Equipment: Bench",
                                  futureActivityList: queryActivityList(
                                      "equipment", "bench"))));
                    },
                    child: Text("Bench"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Equipment: Machine",
                                  futureActivityList: queryActivityList(
                                      "equipment", "machine"))));
                    },
                    child: Text("Machine"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (__) => new CategoryPage(
                                  categoryName: "Equipment: None",
                                  futureActivityList:
                                      queryActivityList("equipment", ""))));
                    },
                    child: Text("None"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
