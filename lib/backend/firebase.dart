import 'package:firebase_database/firebase_database.dart';
import '../models/ZotUser.dart';
import 'package:zotivity/models/activityCategory.dart';

// showing uses of the firebase DB
// should be imported in the main.dart
// calling printAllActivities() will show all the activities in the DB in the console

final databaseReference = FirebaseDatabase.instance.reference();


addSomeData(){
  databaseReference.child("chocolate chip cookies").set({
    'category': 'baking',
    'name': 'chocolate chip cookies',
    'description':"",
    'resources':"https://basicswithbabish.co/basicsepisodes/2017/10/23/baressentials-7xwwz",
  });

  databaseReference.child("dinner rolls").set({
    'category': 'baking',
    'name': 'dinner rolls',
    'description':"",
    'resources':"https://youtu.be/jFsjf7LevEU",
  });
}

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

printAllActivities(){
  databaseReference.once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
  });
}

