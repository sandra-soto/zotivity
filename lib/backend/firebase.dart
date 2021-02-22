import 'package:firebase_database/firebase_database.dart';
import '../models/user.dart';
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

addUser(User _user) {
  Map<ActivityCategory, bool> _interests = _user.getInterests();

  databaseReference.child(_user.id).set({
    'id': _user.getId(),
    'firstName': _user.getFirstName(),
    'lastName': _user.getLastName(),
    'age': _user.getAge(),
    'indoor': _interests[ActivityCategory.category_indoor],
    'outdoor': _interests[ActivityCategory.category_outdoor],
    'gym': _interests[ActivityCategory.category_gym]
  });
}

addActivity() {
  // databaseReference.child("Yoga").set({
  //   'title': 'Yoga',
  //   'imgLink': 'https://miro.medium.com/max/11630/0*C5Y8W-6e9OVIB3AM',
  //   'category': 'indoor',
  //   'time': '50',
  //   'intensity': '1',
  //   'focus': 'none',
  //   'description': 'description for yoga',
  //   'equipment': 'yoga_mat',
  //   'resources': 'resources for yoga'
  // });
}

Map<String, ActivityCategory> categoryMap = {
  "category_outdoor": ActivityCategory.category_outdoor,
  "category_indoor": ActivityCategory.category_indoor,
  "category_gym": ActivityCategory.category_gym,
};
Map<String, BodyFocus> bodyfocusMap = {
  "bodyfocus_arms": BodyFocus.bodyfocus_arms,
  "bodyfocus_chest": BodyFocus.bodyfocus_chest,
  "bodyfocus_shoulders": BodyFocus.bodyfocus_shoulders,
  "bodyfocus_back": BodyFocus.bodyfocus_back,
  "bodyfocus_legs": BodyFocus.bodyfocus_legs,
  "bodyfocus_none": BodyFocus.bodyfocus_none,
};
Map<String, Equipment> equipmentMap = {
  "equipment_none": Equipment.equipment_none,
  "equipment_gym": Equipment.equipment_gym,
  "equipment_bike": Equipment.equipment_bike,
  "equipment_dumbbells": Equipment.equipment_dumbbells,
  "equipment_resistance_bands": Equipment.equipment_resistance_bands,
  "equipment_pull_up_bar": Equipment.equipment_pull_up_bar,
  "equipment_yoga_mat": Equipment.equipment_yoga_mat,
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
          int.parse(element["time"]),
          int.parse(element["intensity"]),
          bodyfocusMap[element["focus"]],
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
          int.parse(element["time"]),
          int.parse(element["intensity"]),
          bodyfocusMap[element["focus"]],
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
