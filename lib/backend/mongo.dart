import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/models/ZotUser.dart';

var mongoDB;

initMongoDB() async {
  mongoDB = await Db.create(Uri.encodeFull("mongodb+srv://dbUser:dbUserPassword@cluster0.vrrjf.mongodb.net/zotivity?retryWrites=true&w=majority"));
  await mongoDB.open();
}


addMongoCalendarRecs(List<DateTime> calendarRecs) async{
  var users = await mongoDB.collection('user');
  var retrievedUser = await users.find(where.eq('email', currentUserEmail)).toList();
  print("looking for user with $currentUserEmail");
  if (retrievedUser.length != 0){
    print("Retrieved from MongoDB: ${ZotUser.fromJson(retrievedUser[0])} -- Updated");
    await users.update(where.eq('email', currentZotUser.email),  modify.set('calendarRecs', calendarRecs));

  }
}


removeMongoCalendarRecs() async{
  var users = await mongoDB.collection('user');
  var retrievedUser = await users.find(where.eq('email', currentUserEmail)).toList();
  print("looking for user with $currentUserEmail");
  if (retrievedUser.length != 0){
    print("Retrieved from MongoDB: ${ZotUser.fromJson(retrievedUser[0])} -- Updated");
    await users.update(where.eq('email', currentZotUser.email),  modify.set('calendarRecs', []));

  }
}


// update the user if it exists, otherwise add it
updateMongoUser() async{
  var users = await mongoDB.collection('user');
  var retrievedUser = await users.find(where.eq('email', currentUserEmail)).toList();
  print("looking for user with $currentUserEmail");
  if (retrievedUser.length != 0){
    print("Retrieved from MongoDB: ${ZotUser.fromJson(retrievedUser[0])} -- Updated to ${currentZotUser.toJson()}");
    await users.update(where.eq('email', currentZotUser.email), currentZotUser.toJson());

  }
  else{
    print("Adding user to DB: ${currentZotUser.toJson()}");
    users.insertAll([currentZotUser.toJson()]);
  }

}

// retrieve the user if it exists or add it to the DB
getMongoUser() async{

    var users = await mongoDB.collection('user');
    var retrievedUser = await users.find(where.eq('email', currentUserEmail)).toList();
    print("looking for user with $currentUserEmail");
    if (retrievedUser.length != 0){
      currentZotUser = ZotUser.fromJson(retrievedUser[0]);
      print("Retrieved from MongoDB: $currentZotUser");
    }
    else {
      print("$currentZotUser not found in DB");
    }
}


getMongoCalendarRecs() async {
  var users = await mongoDB.collection('user');
  var retrievedUser = await users.find(where.eq('email', currentUserEmail)).toList();
  if (retrievedUser.length != 0){
    var calendarRecs = retrievedUser[0]["calendarRecs"];
    if(calendarRecs != null){
        return calendarRecs.cast<DateTime>();
    }
    return calendarRecs;
  }

}

