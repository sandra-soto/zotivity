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
    addMongoCalendarRecs(calendarRecs);
    print("added recs to db");
    return calendarRecs;

  }

}


class CalendarPage extends StatefulWidget{
  final List<DateTime> items;
  CalendarPage({Key key, @required this.items}) : super(key: key);
  @override
  _calendarPageState createState() => _calendarPageState();
}


class _calendarPageState extends State<CalendarPage>{
  List<DateTime> items;
  @override
  initState(){
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Best times to exercise"),
      ),
      body: Column(
        children: <Widget>[
          notifsSwitch(items:items),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // Let the ListView know how many items it needs to build.
            itemCount: items!= null ? items.length : 0,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
            itemBuilder: (context, index) {
            final item = items[index];

            return  Card(
              child: ListTile(
                leading: Icon(Icons.calendar_today_sharp, color:context.theme.accentColor),
                title: Text(format(item.toLocal()),
                    style: TextStyle(color: context.theme.accentColor)),
                trailing: Icon(Icons.more_vert),
              ),
            );
          },
        ),
        ],
      ),
    );
  }

}



class notifsSwitch extends StatefulWidget {
  List<DateTime> items;
  notifsSwitch({@required this.items});
  @override
  _notifsState createState() => _notifsState();
}

class _notifsState extends State<notifsSwitch> {
  bool isSwitched = sharedPrefs.getBool("notifsOn") != null ?  sharedPrefs.getBool("notifsOn") : false;
  @override
  initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text("Receive notifications"),
      value: isSwitched,
      onChanged: (value) async{
        await sharedPrefs.setBool("notifsOn", value);
        setState(() {
          isSwitched = value;
          print("Notifs toggled");

        });
        if (value == false){
          cancelAllNotifications();
        }
        else {
          scheduleRoutineNotifBatch(widget.items);
          showNotifToggle();
        }
      },
      activeTrackColor: Colors.yellow,
      activeColor: Colors.orangeAccent,
    );
  }
}
