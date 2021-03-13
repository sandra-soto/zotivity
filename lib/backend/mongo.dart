import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/models/ZotUser.dart';

var mongoDB;

initMongoDB() async {
  mongoDB = await Db.create(Uri.encodeFull("mongodb+srv://dbUser:dbUserPassword@cluster0.vrrjf.mongodb.net/zotivity?retryWrites=true&w=majority"));
  await mongoDB.open();
}

closeMongoDB() async {
  await mongoDB.close();
}


addMongoCalendarRecs(List<DateTime> calendarRecs) async{
  try{
    var users = await mongoDB.collection('user');
    var retrievedUser = await users.find(where.eq('email', currentUserEmail)).toList();
    print("recs: looking for user with $currentUserEmail");
    if (retrievedUser.length != 0){
      print("Retrieved from MongoDB: ${ZotUser.fromJson(retrievedUser[0])} -- Updated");
      await users.update(where.eq('email', currentZotUser.email),  modify.set('calendarRecs', calendarRecs));

    }
  }
  catch(err){
    print(err);
    await initMongoDB();
    addMongoCalendarRecs(calendarRecs);
  }
  }



removeMongoCalendarRecs() async{
  try{
    var users = await mongoDB.collection('user');
    var retrievedUser = await users.find(where.eq('email', currentUserEmail)).toList();
    print("rem recs: looking for user with $currentUserEmail");
    if (retrievedUser.length != 0){
      print("Retrieved from MongoDB: ${ZotUser.fromJson(retrievedUser[0])} -- Updated");
      await users.update(where.eq('email', currentZotUser.email),  modify.set('calendarRecs', []));

    }
  }
  catch(err){
    print(err);
    await initMongoDB();
    removeMongoCalendarRecs();
  }

}


// update the user if it exists, otherwise add it
updateMongoUser() async{
    try{
      var users = await mongoDB.collection('user');
      var retrievedUser = await users.find(where.eq('email', currentUserEmail))
          .toList();
      print(" update: looking for user with $currentUserEmail");
      if (retrievedUser.length != 0) {
        print("Retrieved from MongoDB: ${ZotUser.fromJson(
            retrievedUser[0])} -- Updated to ${currentZotUser.toJson()}");
        await users.update(
            where.eq('email', currentZotUser.email), currentZotUser.toJson());
      }
      else{
        print("Adding user to DB: ${currentZotUser.toJson()}");
        users.insertAll([currentZotUser.toJson()]);
      }
    }
    catch(err){
      print(err);
      await initMongoDB();
      return updateMongoUser();
    }

  }


// retrieve the user if it exists or add it to the DB
getMongoUser() async{
    try{
      var users = await mongoDB.collection('user');
      var retrievedUser = await users.find(where.eq('email', currentUserEmail)).toList();
      print("get: looking for user with $currentUserEmail");
      if (retrievedUser.length != 0){
        currentZotUser = ZotUser.fromJson(retrievedUser[0]);
        print("Retrieved from MongoDB: $currentZotUser");
      }
      else {
        print("$currentZotUser not found in DB");
      }
    }
    catch(err){
      print(err);
      await initMongoDB();
      getMongoUser();
    }

}


getMongoCalendarRecs() async {
  try{
    var users = await mongoDB.collection('user');
    var retrievedUser = await users.find(where.eq('email', currentUserEmail)).toList();
    if (retrievedUser.length != 0){
      var calendarRecs = retrievedUser[0]["calendarRecs"];
      return calendarRecs.cast<DateTime>();
    }
  }
  catch(err){
    print(err);
    await initMongoDB();
    getMongoCalendarRecs();
  }


}


sampleWeightData() async{
  try{
    var users = await mongoDB.collection('user');
    List<int> weight = [
      133, 134, 136, 137, 135, 135, 133, 132, 131, 129, 131, 130
    ];
    await users.update(where.eq('email', currentZotUser.email),  modify.set('weightProgress', weight));
    List<String> dateLog = List<String>();
    for (int i = 0; i < weight.length; i++){
      dateLog.add(DateTime.now().subtract(Duration(days:7*i)).toString());
    }
    await users.update(where.eq('email', currentZotUser.email),  modify.set('weightDateLog', dateLog));
  }
  catch(err){
    print(err);
    await initMongoDB();
    getMongoCalendarRecs();
  }
}

