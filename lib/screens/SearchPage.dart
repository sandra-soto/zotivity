import 'package:flutter/material.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/models/activityCategory.dart';
import './CategoryPage.dart';


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
  bool matchAll = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
// <<<<<<< HEAD
//         title: Text("Search Page"),
//       ),
//       body: Container(
//         width: double.infinity,
//         margin: EdgeInsets.all(100),
//         alignment: Alignment.bottomCenter,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Text(
//                 "Categories:",
//                 style: Theme.of(context).textTheme.headline1,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     new MaterialPageRoute(
//                         builder: (__) => new CategoryPage(
//                             categoryName: ActivityCategory.indoor,
//                             futureActivityList:
//                                 getActivitiesByCategory("indoor"))));
//               },
//               child: Text("Indoor"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     new MaterialPageRoute(
//                         builder: (__) => new CategoryPage(
//                             categoryName: ActivityCategory.outdoor,
//                             futureActivityList:
//                                 getActivitiesByCategory("outdoor"))));
//               },
//               child: Text("Outdoor"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     new MaterialPageRoute(
//                         builder: (__) => new CategoryPage(
//                             categoryName: ActivityCategory.gym,
//                             futureActivityList:
//                                 getActivitiesByCategory("gym"))));
//               },
//               child: Text("Gym"),
//             ),
//           ],
// =======
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
              Row(
                children: [
                  Text("Filter Type: ", style: TextStyle(fontSize: 15)),
                  RaisedButton(
                    color: matchAll ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {
                        matchAll = !matchAll;
                        indoor = false;
                        outdoor = false;
                        gym = false;
                        arms = false;
                        chest = false;
                        shoulders = false;
                        torso = false;
                        back = false;
                        glutes = false;
                        legs = false;
                        full = false;
                        focusNone = false;
                        bike = false;
                        dumbbells = false;
                        barbell = false;
                        resistanceBand = false;
                        pullupBar = false;
                        yogamat = false;
                        bench = false;
                        machine = false;
                        equipmentNone = false;
                        low = false;
                        medium = false;
                        high = false;
                      });
                    },
                    child: Text("Match All"),
                  ),
                  RaisedButton(
                    color: matchAll ? Colors.grey.shade300 : Colors.blue,
                    onPressed: () {
                      setState(() {
                        matchAll = !matchAll;
                        indoor = false;
                        outdoor = false;
                        gym = false;
                        arms = false;
                        chest = false;
                        shoulders = false;
                        torso = false;
                        back = false;
                        glutes = false;
                        legs = false;
                        full = false;
                        focusNone = false;
                        bike = false;
                        dumbbells = false;
                        barbell = false;
                        resistanceBand = false;
                        pullupBar = false;
                        yogamat = false;
                        bench = false;
                        machine = false;
                        equipmentNone = false;
                        low = false;
                        medium = false;
                        high = false;
                      });
                    },
                    child: Text("Match Any"),
                  )
                ],
              ),
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
                      setState(() {
                        indoor = !indoor;
                        if (matchAll) {
                          outdoor = false;
                          gym = false;
                        }
                      });
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
                      setState(() {
                        outdoor = !outdoor;
                        if (matchAll) {
                          indoor = false;
                          gym = false;
                        }
                      });
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
                      setState(() {
                        gym = !gym;
                        if (matchAll) {
                          indoor = false;
                          outdoor = false;
                        }
                      });
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
                      setState(() {
                        arms = !arms;
                        if (matchAll) {
                          chest = false;
                          shoulders = false;
                          torso = false;
                          back = false;
                          glutes = false;
                          legs = false;
                          full = false;
                          focusNone = false;
                        }
                      });
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
                      setState(() {
                        chest = !chest;
                        if (matchAll) {
                          arms = false;
                          shoulders = false;
                          torso = false;
                          back = false;
                          glutes = false;
                          legs = false;
                          full = false;
                          focusNone = false;
                        }
                      });
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
                      setState(() {
                        shoulders = !shoulders;
                        if (matchAll) {
                          arms = false;
                          chest = false;
                          torso = false;
                          back = false;
                          glutes = false;
                          legs = false;
                          full = false;
                          focusNone = false;
                        }
                      });
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
                      setState(() {
                        torso = !torso;
                        if (matchAll) {
                          arms = false;
                          chest = false;
                          shoulders = false;
                          back = false;
                          glutes = false;
                          legs = false;
                          full = false;
                          focusNone = false;
                        }
                      });
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
                      setState(() {
                        back = !back;
                        if (matchAll) {
                          arms = false;
                          chest = false;
                          shoulders = false;
                          torso = false;
                          glutes = false;
                          legs = false;
                          full = false;
                          focusNone = false;
                        }
                      });
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
                      setState(() {
                        glutes = !glutes;
                        if (matchAll) {
                          arms = false;
                          chest = false;
                          shoulders = false;
                          torso = false;
                          back = false;
                          legs = false;
                          full = false;
                          focusNone = false;
                        }
                      });
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
                      setState(() {
                        legs = !legs;
                        if (matchAll) {
                          arms = false;
                          chest = false;
                          shoulders = false;
                          torso = false;
                          back = false;
                          glutes = false;
                          full = false;
                          focusNone = false;
                        }
                      });
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
                      setState(() {
                        full = !full;
                        if (matchAll) {
                          arms = false;
                          chest = false;
                          shoulders = false;
                          torso = false;
                          back = false;
                          glutes = false;
                          legs = false;
                          focusNone = false;
                        }
                      });
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
                      setState(() {
                        focusNone = !focusNone;
                        if (matchAll) {
                          arms = false;
                          chest = false;
                          shoulders = false;
                          torso = false;
                          back = false;
                          glutes = false;
                          legs = false;
                          full = false;
                        }
                      });
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
                      setState(() {
                        if (matchAll) {
                          medium = false;
                          high = false;
                        }
                        low = !low;
                      });
                    },
                    child: Text("Low"),
                  ),
                  RaisedButton(
                    color: medium ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {
                        if (matchAll) {
                          low = false;
                          high = false;
                        }
                        medium = !medium;
                      });
                    },
                    child: Text("Medium"),
                  ),
                  RaisedButton(
                    color: high ? Colors.blue : Colors.grey.shade300,
                    onPressed: () {
                      setState(() {
                        if (matchAll) {
                          low = false;
                          medium = false;
                        }
                        high = !high;
                      });
                    },
                    child: Text("High"),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(35),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (__) => new CategoryPage(
                              categoryName: "Search Results",
                              futureActivityList: getActivityList(
                                  matchAll,
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
// >>>>>>> kelson
        ),
      ),
    );
  }
}
