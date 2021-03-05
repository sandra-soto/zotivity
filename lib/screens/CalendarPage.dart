import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zotivity/backend/calendarUtil.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/backend/mongo.dart';
import '../models/Activity.dart';
import 'package:get/get.dart';


getCalendarRecs() async{
  //Todo:remove this later
  await removeMongoCalendarRecs();
  List<DateTime> calendarRecs = await getMongoCalendarRecs();

  print("Debug time $calendarRecs");



  // if there are calendarRecs in the database, then use those
  if (calendarRecs != null && calendarRecs.length != 0){
    calendarRecs.add(DateTime.now().add(Duration(seconds: 15)));

    print("retrieved recs from DB");
    Get.to(() => CalendarPage(items: calendarRecs));
  }
  // otherwise, generate new Recommendations and add them to the DB
  else{

    List<DateTime> calendarRecs = await getBestFreeTime();
    // set notifications for each dateTime in the list, and added a test one
    calendarRecs.add(DateTime.now().add(Duration(seconds: 5)));
    int id = 0;
    calendarRecs.forEach((element) {
      scheduledRoutine(id++, element);
    });
    addMongoCalendarRecs(calendarRecs);
    print("added recs to db");
    Get.to(() => CalendarPage(items: calendarRecs));
  }

}

class CalendarPage extends StatelessWidget {
  final List<DateTime> items;


  CalendarPage({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Calendar';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items!= null ? items.length : 0,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return  Card(
              child: ListTile(
                leading: Icon(Icons.calendar_today_sharp, color:Colors.white),
                title: Text(format(item.toLocal()),
                    style: TextStyle(color:Colors.white)),
                tileColor: Colors.indigoAccent,
                trailing: Icon(Icons.more_vert),
              ),
            );
          },
        ),
      ),
    );
  }
}



