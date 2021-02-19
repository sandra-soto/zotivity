import 'package:firebase_database/firebase_database.dart';
import '../models/ZotUser.dart';
import '../models/Activity.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

// showing uses of the firebase DB
// should be imported in the main.dart
// calling printAllActivities() will show all the activities in the DB in the console

final databaseReference = FirebaseDatabase.instance.reference();

addUser(ZotUser _user) {
  Map<ActivityCategory, bool> _interests = _user.getInterests();

  databaseReference.child(_user.id).set({
    'id': _user.getId(),
    'firstName': _user.getFirstName(),
    'lastName':  _user.getLastName(),
    'age': _user.getAge(),
    'indoor': _interests[ActivityCategory.indoor],
    'outdoor': _interests[ActivityCategory.outdoor],
    'gym': _interests[ActivityCategory.gym]
  });
}

addActivity(Activity _activity) {
  databaseReference.child(_activity.getTitle()).set(_activity.toMap());
}

void insertExcel() async {
  ByteData data = await rootBundle.load("assets/test_data.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  var table = excel.tables.keys.first;

  for (var row in excel.tables[table].rows) {
    addActivity(Activity.fromList(row));
  }
}

printAllActivities(){
  databaseReference.once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
  });
}

