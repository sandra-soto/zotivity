import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:intl/intl.dart';
import 'package:zotivity/models/ZotUser.dart';
import 'globals.dart';

// source: https://stackoverflow.com/questions/62564746/dart-get-date-of-next-friday
extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return this.add(
      Duration(
        days: (day - this.weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}


Future<Map<int, List<DateTimeRange>>> getBusyTime() async {
  var data = await CalendarApi(httpClient).calendarList.list();

  // calendarIDs is a list of Map in the format of {"id": sdasda@google.calendar.com}
  List<Map<String, String>> calendarIDs = List<Map<String, String>>();
  data.items.forEach((element) {
    // exclude holiday calendar, this one's only for the US though so there's prob codes for every country
    if(element.id != 'en.usa#holiday@group.v.calendar.google.com'){
      //print('Calendar found for $currentUserEmail: ${element.id}, ${element.summary}, ${element.description}');
      calendarIDs.add({'id': element.id});
    }
  });

  // checking availability from now to the remainder of the week
  DateTime now = new DateTime.now();
  DateTime nextMonday = now.next(DateTime.monday);
  nextMonday = new DateTime(nextMonday.year, nextMonday.month, nextMonday.day, 0, 0);


  var newFormat = DateFormat.yMd().add_jm() ;

  //freeBusy API requires DateTimes to be in UTC format apparently
  var freeBusyReq = {
    "timeMin": "${now.toUtc()}",
    "timeMax": "${nextMonday.toUtc()}",
    "timeZone": "UTC",
    "items": calendarIDs,
  };
  try{

    var freeBusyData = await CalendarApi(httpClient).freebusy.query(FreeBusyRequest.fromJson(freeBusyReq));
    Map<int, List<DateTimeRange>> allBusyPeriods = Map<int, List<DateTimeRange>>();

    Map calData = freeBusyData.toJson()['calendars'];
    calData.forEach((calendar, busyPeriod){
      var busyList = busyPeriod['busy'];
      //print("Showing busy periods for calendar ${calendar}:");
      for(var i = 0; i < busyList.length; i++){
        var busyStart = DateTime.parse(busyPeriod['busy'][i]['start']).toLocal();
        var busyEnd = DateTime.parse(busyPeriod['busy'][i]['end']).toLocal();
        //print("Busy from ${newFormat.format(busyStart)} to ${newFormat.format(busyEnd)}");

        if (allBusyPeriods[busyStart.weekday] == null){
          allBusyPeriods[busyStart.weekday] = new List<DateTimeRange>();
        }
        allBusyPeriods[busyStart.weekday].add(DateTimeRange(start:busyStart, end:busyEnd));

      }
      //print("\n");
    });

    print(allBusyPeriods);
    return allBusyPeriods;
  }
  catch(err){
    print(err);
  }
}

getBestFreeTime() async{
  Map<int, List<DateTimeRange>> allBusyTime = await getBusyTime();
  int timeSlotsToFind = currentUser.getIntensity();
  print("Should find $timeSlotsToFind timeslots per week");

  // recalculate number of timeSlots to find depending on how many days left in the week
  DateTime now = new DateTime.now();
  //Todo: fix this so its more precise later
  int remainingDays = 7 - now.weekday;
  if (remainingDays < timeSlotsToFind){
    timeSlotsToFind = remainingDays;
  }

  var blah = {1:"mon", 2:"tues", 3:"wed", 4: "thurs", 5:"fri", 6:"sat", 7:"sun"};

  print("Based on today, will find $timeSlotsToFind timeslots for this week");
  for(int i = 0; i < timeSlotsToFind; i++){
    print("Have to find a timeslot for ${blah[now.weekday + i]}");
  }

  List<DateTime> timeSlots = new List<DateTime>();
  print(currentUser.getAvailWindow()[ZotUser.TIME_MORN]);

}





