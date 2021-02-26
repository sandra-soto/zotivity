import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zotivity/backend/calendarUtil.dart';
import '../models/Activity.dart';
import 'package:get/get.dart';


getCalendarRecs() async{
  List<DateTime> items = await getBestFreeTime();
  print(items);
  Get.to(() => CalendarPage(items: items));
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
                title: Text(format(item),
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



