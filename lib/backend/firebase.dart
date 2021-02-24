import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:zotivity/models/ZotUser.dart';
import 'package:zotivity/models/activityCategory.dart';
import '../models/Activity.dart';
import '../models/activityCategory.dart';
import '../models/BodyFocus.dart';
import '../models/Equipment.dart';

// showing uses of the firebase DB
// should be imported in the main.dart
// calling printAllActivities() will show all the activities in the DB in the console

final databaseReference = FirebaseDatabase.instance.reference();

addSomeData() {
  databaseReference.child("chocolate chip cookies").set({
    'category': 'baking',
    'name': 'chocolate chip cookies',
    'description': "",
    'resources':
    "https://basicswithbabish.co/basicsepisodes/2017/10/23/baressentials-7xwwz",
  });

  databaseReference.child("dinner rolls").set({
    'category': 'baking',
    'name': 'dinner rolls',
    'description': "",
    'resources': "https://youtu.be/jFsjf7LevEU",
  });
}

//addUser(ZotUser _user) {
//  Map<ActivityCategory, bool> _interests = _user.getInterests();
//
//  databaseReference.child(_user.id).set({
//    'id': _user.getId(),
//    'firstName': _user.getFirstName(),
//    'lastName': _user.getLastName(),
//    'age': _user.getAge(),
//    'indoor': _interests[ActivityCategory.indoor],
//    'outdoor': _interests[ActivityCategory.outdoor],
//    'gym': _interests[ActivityCategory.gym]
//  });
//}

addActivity(Activity _activity) {
  databaseReference.child(_activity.getTitle()).set(_activity.toMap());
}

void insertExcel() async {
  // ByteData data = await rootBundle.load("assets/test_data.xlsx");
  ByteData data = await rootBundle.load("assets/activities.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  var table = excel.tables.keys.first;

  for (var row in excel.tables[table].rows) {
    addActivity(Activity.fromList(row));
  }
}

Map<String, ActivityCategory> categoryMap = {
  "category_outdoor": ActivityCategory.outdoor,
  "category_indoor": ActivityCategory.indoor,
  "category_gym": ActivityCategory.gym,
};
Map<String, BodyFocus> BodyFocusMap = {
  "BodyFocus_arms": BodyFocus.arms,
  "BodyFocus_chest": BodyFocus.chest,
  "BodyFocus_shoulders": BodyFocus.shoulders,
  "BodyFocus_back": BodyFocus.back,
  "BodyFocus_legs": BodyFocus.legs,
};
Map<String, Equipment> equipmentMap = {
  // "equipment_none": Equipment.none,
  "equipment_gym": Equipment.machine,
  "equipment_bike": Equipment.bike,
  "equipment_dumbbells": Equipment.dumbbells,
  "equipment_resistance_bands": Equipment.resistance_bands,
  "equipment_pull_up_bar": Equipment.pull_up_bar,
  "equipment_yoga_mat": Equipment.yoga_mat,
};

getActivityByName(String name) {
  List lists = new List();
  List<Activity> activityList = new List();
  return databaseReference
      .orderByChild("title")
      .equalTo(name)
      .once()
      .then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, values) {
      lists.add(values);
    });
    lists.forEach((element) {
      activityList.add(new Activity(
          element["title"],
          categoryMap[element["category"]],
          0, //Todo: change this later, added bc activities require reps
          int.parse(element["time"]),
          int.parse(element["intensity"]),
          BodyFocusMap[element["focus"]],
          element["description"],
          [equipmentMap[element["equipment"]]],
          element["imgLink"],
          element["resources"]));
    });
    return activityList[0];
  });
}

getActivitiesByCategory(String category) {
  List lists = new List();
  List<Activity> activityList = new List();
  return databaseReference
      .orderByChild("category")
      .equalTo(category)
      .once()
      .then((DataSnapshot snapshot) {
    // print(snapshot.value);
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, values) {
      lists.add(values);
    });
    lists.forEach((element) {
      // print(element["title"]);
      activityList.add(new Activity(
          element["title"],
          categoryMap[element["category"]],
          0, //Todo: change this later, added bc activities require reps
          int.parse(element["time"]),
          int.parse(element["intensity"]),
          BodyFocusMap[element["focus"]],
          element["description"],
          [equipmentMap[element["equipment"]]],
          element["imgLink"],
          element["resources"]));
    });
    return activityList;
  });
}

testFunction() {
  // DataSnapshot s;
  // databaseReference.once().then((DataSnapshot snapshot) {
  //   s = snapshot;
  //   print('Data : ${snapshot.value}');
  // });
  // print('Data : ${s.value}');
  // print(getActivityByName("Deadlift"));
  // print(getActivitiesByCategory("category_gym"));

  // Future<List<Activity>> l = getCategoryActivityList("category_gym");
  // // print(l);
  // List<Activity> pls = new List();
  // l.then((value) => value.forEach((element) {
  //       // print(element);
  //       pls.add(new Activity(
  //           element.getTitle(),
  //           element.getCategory(),
  //           element.getTime(),
  //           element.getIntensity(),
  //           element.getFocus(),
  //           element.getDescription(),
  //           element.getEquipment(),
  //           element.getImgLink(),
  //           element.getResources()));
  //       // print(pls);
  //     }));
  // print(pls);
  // l.forEach((element) => print(element));
}
