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
  bool indoor = false;
  bool outdoor = false;
  bool gym = false;
  bool arms = false;
  bool chest = false;
  bool shoulders = false;
  bool torso = false;
  bool back = false;
  bool glutes = false;
  bool legs = false;
  bool full = false;
  bool focusNone = false;
  bool bike = false;
  bool dumbbells = false;
  bool barbell = false;
  bool resistanceBand = false;
  bool pullupBar = false;
  bool yogamat = false;
  bool bench = false;
  bool machine = false;
  bool equipmentNone = false;
  bool low = false;
  bool medium = false;
  bool high = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter Selection"),
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
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Categories:",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: indoor ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {indoor = !indoor; outdoor = false; gym = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Category: Indoor",
                      //             futureActivityList:
                      //                 getActivitiesByCategory("indoor"))));
                    },
                    child: Text("Indoor"),
                  ),
                  RaisedButton(
                    color: outdoor ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {outdoor = !outdoor; indoor = false; gym = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Category: Outdoor",
                      //             futureActivityList:
                      //                 getActivitiesByCategory("outdoor"))));
                    },
                    child: Text("Outdoor"),
                  ),
                  RaisedButton(
                    color: gym ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {gym = !gym; indoor = false; outdoor = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Category: Gym",
                      //             futureActivityList:
                      //                 getActivitiesByCategory("gym"))));
                    },
                    child: Text("Gym"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Body Focus:",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: arms ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {arms = !arms; chest = false; shoulders = false; torso = false; back = false; glutes = false; legs = false; full = false; focusNone = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Body Focus: Arms",
                      //             futureActivityList:
                      //                 queryActivityList("focus", "arms"))));
                    },
                    child: Text("Arms"),
                  ),
                  RaisedButton(
                    color: chest ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {arms = false; chest = !chest; shoulders = false; torso = false; back = false; glutes = false; legs = false; full = false; focusNone = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Body Focus: Chest",
                      //             futureActivityList:
                      //                 queryActivityList("focus", "chest"))));
                    },
                    child: Text("Chest"),
                  ),
                  RaisedButton(
                    color: shoulders ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {arms = false; chest = false; shoulders = !shoulders; torso = false; back = false; glutes = false; legs = false; full = false; focusNone = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Body Focus: Shoulders",
                      //             futureActivityList: queryActivityList(
                      //                 "focus", "shoulders"))));
                    },
                    child: Text("Shoulders"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: torso ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {arms = false; chest = false; shoulders = false; torso = !torso; back = false; glutes = false; legs = false; full = false; focusNone = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Body Focus: Torso",
                      //             futureActivityList:
                      //                 queryActivityList("focus", "torso"))));
                    },
                    child: Text("Torso"),
                  ),
                  RaisedButton(
                    color: back ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {arms = false; chest = false; shoulders = false; torso = false; back = !back; glutes = false; legs = false; full = false; focusNone = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Body Focus: Back",
                      //             futureActivityList:
                      //                 queryActivityList("focus", "back"))));
                    },
                    child: Text("Back"),
                  ),
                  RaisedButton(
                    color: glutes ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {arms = false; chest = false; shoulders = false; torso = false; back = false; glutes = !glutes; legs = false; full = false; focusNone = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Body Focus: Glutes",
                      //             futureActivityList:
                      //                 queryActivityList("focus", "glutes"))));
                    },
                    child: Text("Glutes"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: legs ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {arms = false; chest = false; shoulders = false; torso = false; back = false; glutes = false; legs = !legs; full = false; focusNone = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Body Focus: Legs",
                      //             futureActivityList:
                      //                 queryActivityList("focus", "legs"))));
                    },
                    child: Text("Legs"),
                  ),
                  RaisedButton(
                    color: full ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {arms = false; chest = false; shoulders = false; torso = false; back = false; glutes = false; legs = false; full = !full; focusNone = false;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Body Focus: Full",
                      //             futureActivityList:
                      //                 queryActivityList("focus", "full"))));
                    },
                    child: Text("Full"),
                  ),
                  RaisedButton(
                    color: focusNone ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {arms = false; chest = false; shoulders = false; torso = false; back = false; glutes = false; legs = false; full = false; focusNone = !focusNone;});
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Body Focus: None",
                      //             futureActivityList:
                      //                 queryActivityList("focus", ""))));
                    },
                    child: Text("None"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Equipment:",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: bike ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => bike = !bike);
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Equipment: Bike",
                      //             futureActivityList:
                      //                 queryActivityList("equipment", "bike"))));
                    },
                    child: Text("Bike"),
                  ),
                  RaisedButton(
                    color: dumbbells ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => dumbbells = !dumbbells);
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Equipment: Dumbbells",
                      //             futureActivityList: queryActivityList(
                      //                 "equipment", "dumbbells"))));
                    },
                    child: Text("Dumbbells"),
                  ),
                  RaisedButton(
                    color: barbell ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => barbell = !barbell);
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Equipment: Barbell",
                      //             futureActivityList: queryActivityList(
                      //                 "equipment", "barbell"))));
                    },
                    child: Text("Barbell"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: resistanceBand ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => resistanceBand = !resistanceBand);
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Equipment: Resistance Bands",
                      //             futureActivityList: queryActivityList(
                      //                 "equipment", "resistance bands"))));
                    },
                    child: Text("Resistance Band"),
                  ),
                  RaisedButton(
                    color: pullupBar ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => pullupBar = !pullupBar);
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Equipment: Pullup Bar",
                      //             futureActivityList: queryActivityList(
                      //                 "equipment", "pull up bar"))));
                    },
                    child: Text("Pullup Bar"),
                  ),
                  RaisedButton(
                    color: yogamat ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => yogamat = !yogamat);
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Equipment: Yoga Mat",
                      //             futureActivityList: queryActivityList(
                      //                 "equipment", "yoga mat"))));
                    },
                    child: Text("Yoga Mat"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: bench ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => bench = !bench);
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Equipment: Bench",
                      //             futureActivityList: queryActivityList(
                      //                 "equipment", "bench"))));
                    },
                    child: Text("Bench"),
                  ),
                  RaisedButton(
                    color: machine ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => machine = !machine);
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Equipment: Machine",
                      //             futureActivityList: queryActivityList(
                      //                 "equipment", "machine"))));
                    },
                    child: Text("Machine"),
                  ),
                  RaisedButton(
                    color: equipmentNone ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() => equipmentNone = !equipmentNone);
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (__) => new CategoryPage(
                      //             categoryName: "Equipment: None",
                      //             futureActivityList:
                      //                 queryActivityList("equipment", ""))));
                    },
                    child: Text("None"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Intensity:",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: low ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {low = !low; medium = false; high = false;});
                    },
                    child: Text("Low"),
                  ),
                  RaisedButton(
                    color: medium ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {medium = !medium; low = false; high = false;});
                    },
                    child: Text("Medium"),
                  ),
                  RaisedButton(
                    color: high ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {high = !high; low = false; medium = false;});
                    },
                    child: Text("High"),
                  ),
                ],
              ),
              Container(margin: EdgeInsets.all(50),),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) =>
                          new CategoryPage(
                              categoryName: "Search Results",
                              futureActivityList:
                              getActivityList(
                                  indoor,
                                  outdoor,
                                  gym,
                                  arms,
                                  chest,
                                  shoulders,
                                  torso,
                                  back,
                                  glutes,
                                  legs,
                                  full,
                                  focusNone,
                                  bike,
                                  dumbbells,
                                  barbell,
                                  resistanceBand,
                                  pullupBar,
                                  yogamat,
                                  bench,
                                  machine,
                                  equipmentNone,
                                  low,
                                  medium,
                                  high))));
                },
                child: Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}