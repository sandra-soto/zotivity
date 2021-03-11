import 'package:firebase_database/firebase_database.dart';
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

// addActivity(Activity _activity) {
//   databaseReference.child(_activity.getTitle()).set(_activity.toMap());
// }

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
    values.forEach((key, element) {
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
          element["resources"],
          int.parse(key)));
    });
    return activityList[0];
  });
}

getActivityList(bool matchAll, List<bool> categorySelect, List<bool> intensitySelect, 
                List<bool> focusSelect, List<bool> equipSelect) {
  List<Activity> activityList = [];
  List<Activity> activityList2 = [];
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
        if ( !categorySelect[a.getCategory().index]
            || !intensitySelect[a.getIntensity()]
            || !focusSelect[a.getFocus().index]) {
          activityList.removeAt(i);
          i--;
          continue;
        }
      }

      return activityList;
    }
    else {
      bool anything = false;
      for(int i = 0; i < activityList.length; i++){
        Activity a = activityList[i];
        if ( categorySelect[a.getCategory().index]
            || intensitySelect[a.getIntensity()]
            || focusSelect[a.getFocus().index] ) {
          anything = true;
          activityList2.add(a);
          continue;
        }
      }

      if (anything)
        return activityList2;
      else    // no filter was selected, show everything
        return activityList;
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
     print(snapshot.value);
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, element) {
      activityList.add(new Activity(
          element["title"],
          catToEnum(element["category"]),
          element["reps"],
          element["time"],
          element["intensity"],
          focusToEnum(element["focus"]),
          element["description"],
          stringToList(element["equipment"]),
          element["imgLink"],
          element["resources"],
          int.parse(key)
      ));
    });
    return activityList;
  });
}



getMapActivitiesByCategory(String category) {
  Map<int, Activity> activityMap = Map<int, Activity>();
  return databaseReference
      .orderByChild("category")
      .equalTo(category)
      .once()
      .then((DataSnapshot snapshot) {
    print(snapshot.value);
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, element) {
      activityMap[int.parse(key)] = (new Activity(
          element["title"],
          catToEnum(element["category"]),
          element["reps"],
          element["time"],
          element["intensity"],
          focusToEnum(element["focus"]),
          element["description"],
          stringToList(element["equipment"]),
          element["imgLink"],
          element["resources"],
          int.parse(key)
      ));
    });
    return activityMap;
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
