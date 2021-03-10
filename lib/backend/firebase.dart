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
// Map<String, ActivityCategory> categoryMap = {
//   "outdoor": ActivityCategory.outdoor,
//   "indoor": ActivityCategory.indoor,
//   "gym": ActivityCategory.gym,
// };
// Map<String, BodyFocus> BodyFocusMap = {
//   "arms": BodyFocus.arms,
//   "chest": BodyFocus.chest,
//   "shoulders": BodyFocus.shoulders,
//   "torso": BodyFocus.torso,
//   "back": BodyFocus.back,
//   "glutes": BodyFocus.glutes,
//   "legs": BodyFocus.legs,
//   "full": BodyFocus.full,
//   "": BodyFocus.none,
// };
// Map<String, Equipment> equipmentMap = {
//   // "equipment_none": Equipment.none,
//   "bike": Equipment.bike,
//   "dumbbells": Equipment.dumbbells,
//   "barbell": Equipment.barbell,
//   "resistance_bands": Equipment.resistance_bands,
//   "pull_up_bar": Equipment.pull_up_bar,
//   "yoga_mat": Equipment.yoga_mat,
//   "bench": Equipment.bench,
//   "machine": Equipment.machine,
//   "": Equipment.none
// };

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
      // activityList.add(new Activity(
      //     element["title"],
      //     categoryMap[element["category"]],
      //     element["reps"], //Todo: change this later, added bc activities require reps
      //     element["time"],
      //     element["intensity"],
      //     BodyFocusMap[element["focus"]],
      //     element["description"],
      //     [equipmentMap[element["equipment"]]],
      //     element["imgLink"],
      //     element["resources"]));
      activityList.add(new Activity(
          element["title"],
          catToEnum(element["category"]),
          element["reps"],
          //Todo: change this later, added bc activities require reps
          element["time"],
          element["intensity"],
          focusToEnum(element["focus"]),
          element["description"],
          stringToList(element["equipment"]),
          element["imgLink"],
          element["resources"]));
    });
    return activityList[0];
  });
}

getActivityList(bool matchAll, bool indoor, bool outdoor, bool gym, bool arms, bool chest,
    bool shoulders, bool torso, bool back, bool glutes, bool legs, bool full,
    bool focusNone, bool bike, bool dumbbells, bool barbell,
    bool resistanceBand, bool pullupBar, bool yogamat, bool bench, bool machine,
    bool equipmentNone, bool low, bool medium, bool high) {
  List<Activity> activityList = new List();
  List<Activity> activityList2 = new List();
  return databaseReference
      .once()
      .then((DataSnapshot snapshot) {
    // print(snapshot.value);
    snapshot.value.forEach((element) {
      activityList.add(new Activity(
          element["title"],
          catToEnum(element["category"]),
          element["reps"],
          //Todo: change this later, added bc activities require reps
          element["time"],
          element["intensity"],
          focusToEnum(element["focus"]),
          element["description"],
          stringToList(element["equipment"]),
          element["imgLink"],
          element["resources"]));
    });

    if(matchAll){
      for(int i = 0; i < activityList.length; i++){
        Activity a = activityList[i];
        if(indoor && (a.getCategory() != ActivityCategory.indoor)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(outdoor && (a.getCategory() != ActivityCategory.outdoor)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(gym && (a.getCategory() != ActivityCategory.gym)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(arms && (a.getFocus() != BodyFocus.arms)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(chest && (a.getFocus() != BodyFocus.chest)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(shoulders && (a.getFocus() != BodyFocus.shoulders)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(torso && (a.getFocus() != BodyFocus.torso)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(back && (a.getFocus() != BodyFocus.back)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(glutes && (a.getFocus() != BodyFocus.glutes)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(legs && (a.getFocus() != BodyFocus.legs)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(full && (a.getFocus() != BodyFocus.full)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(focusNone && (a.getFocus() != BodyFocus.none)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(bike && (!a.getEquipment().contains(Equipment.bike))){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(dumbbells && (!a.getEquipment().contains(Equipment.dumbbells))){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(barbell && (!a.getEquipment().contains(Equipment.barbell))){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(resistanceBand && (!a.getEquipment().contains(Equipment.resistance_bands))){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(pullupBar && (!a.getEquipment().contains(Equipment.pull_up_bar))){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(yogamat && (!a.getEquipment().contains(Equipment.yoga_mat))){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(bench && (!a.getEquipment().contains(Equipment.bench))){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(machine && (!a.getEquipment().contains(Equipment.machine))){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(equipmentNone && (!a.getEquipment().contains(Equipment.none))){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(low && (a.getIntensity() != 0)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(medium && (a.getIntensity() != 1)){
          activityList.removeAt(i);
          i--;
          continue;
        }
        if(high && (a.getIntensity() != 2)){
          activityList.removeAt(i);
          i--;
          continue;
        }
      }
      return activityList;
    }
    else {
      if((indoor || outdoor || gym || arms || chest || shoulders || torso || back || glutes || legs || full || focusNone || bike || dumbbells || barbell || resistanceBand || pullupBar || yogamat || bench || machine || equipmentNone || low || medium || high) == false){
        return activityList;
      }
      for(int i = 0; i < activityList.length; i++){
        Activity a = activityList[i];
        if(indoor && (a.getCategory() == ActivityCategory.indoor)){
          activityList2.add(a);
          continue;
        }
        if(outdoor && (a.getCategory() == ActivityCategory.outdoor)){
          activityList2.add(a);
          continue;
        }
        if(gym && (a.getCategory() == ActivityCategory.gym)){
          activityList2.add(a);
          continue;
        }
        if(arms && (a.getFocus() == BodyFocus.arms)){
          activityList2.add(a);
          continue;
        }
        if(chest && (a.getFocus() == BodyFocus.chest)){
          activityList2.add(a);
          continue;
        }
        if(shoulders && (a.getFocus() == BodyFocus.shoulders)){
          activityList2.add(a);
          continue;
        }
        if(torso && (a.getFocus() == BodyFocus.torso)){
          activityList2.add(a);
          continue;
        }
        if(back && (a.getFocus() == BodyFocus.back)){
          activityList2.add(a);
          continue;
        }
        if(glutes && (a.getFocus() == BodyFocus.glutes)){
          activityList2.add(a);
          continue;
        }
        if(legs && (a.getFocus() == BodyFocus.legs)){
          activityList2.add(a);
          continue;
        }
        if(full && (a.getFocus() == BodyFocus.full)){
          activityList2.add(a);
          continue;
        }
        if(focusNone && (a.getFocus() == BodyFocus.none)){
          activityList2.add(a);
          continue;
        }
        if(bike && (a.getEquipment().contains(Equipment.bike))){
          activityList2.add(a);
          continue;
        }
        if(dumbbells && (a.getEquipment().contains(Equipment.dumbbells))){
          activityList2.add(a);
          continue;
        }
        if(barbell && (a.getEquipment().contains(Equipment.barbell))){
          activityList2.add(a);
          continue;
        }
        if(resistanceBand && (a.getEquipment().contains(Equipment.resistance_bands))){
          activityList2.add(a);
          continue;
        }
        if(pullupBar && (a.getEquipment().contains(Equipment.pull_up_bar))){
          activityList2.add(a);
          continue;
        }
        if(yogamat && (a.getEquipment().contains(Equipment.yoga_mat))){
          activityList2.add(a);
          continue;
        }
        if(bench && (a.getEquipment().contains(Equipment.bench))){
          activityList2.add(a);
          continue;
        }
        if(machine && (a.getEquipment().contains(Equipment.machine))){
          activityList2.add(a);
          continue;
        }
        if(equipmentNone && (a.getEquipment().contains(Equipment.none))){
          activityList2.add(a);
          continue;
        }
        if(low && (a.getIntensity() == 0)){
          activityList2.add(a);
          continue;
        }
        if(medium && (a.getIntensity() == 1)){
          activityList2.add(a);
          continue;
        }
        if(high && (a.getIntensity() == 2)){
          activityList2.add(a);
          continue;
        }
      }
      return activityList2;
    }

  });
}

queryActivityList(String query, String value) {
  List lists = new List();
  List<Activity> activityList = new List();
  return databaseReference
      .orderByChild(query)
      .equalTo(value)
      .once()
      .then((DataSnapshot snapshot) {
    // print(snapshot.value);

    // Map<dynamic, dynamic> snapshotMap = new Map();
    // for(int i = 0; i < snapshot.value.length; i++){
    //   if(snapshot.value[i] == null){
    //     snapshotMap[snapshot.value[i]] = 0;
    //   }
    // }
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, values) {
      lists.add(values);
    });
    lists.forEach((element) {
      // print(element["title"]);
      activityList.add(new Activity(
          element["title"],
          catToEnum(element["category"]),
          element["reps"],
          //Todo: change this later, added bc activities require reps
          element["time"],
          element["intensity"],
          focusToEnum(element["focus"]),
          element["description"],
          stringToList(element["equipment"]),
          element["imgLink"],
          element["resources"]));
    });
    return activityList;
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
          catToEnum(element["category"]),
          element["reps"],
          //Todo: change this later, added bc activities require reps
          element["time"],
          element["intensity"],
          focusToEnum(element["focus"]),
          element["description"],
          stringToList(element["equipment"]),
          element["imgLink"],
          element["resources"]));
    });
    return activityList;
  });
}

debugFunction() {
  // databaseReference.orderByChild("equipment").equalTo("").once().then((DataSnapshot snapshot) {
  //   print('Data : ${snapshot.value}');
  // });

  // queryActivityList("focus", "legs");

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
