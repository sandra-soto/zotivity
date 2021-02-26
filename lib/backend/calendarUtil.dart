import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:intl/intl.dart';
import 'package:zotivity/models/ZotUser.dart';
import 'dart:math';
import 'globals.dart';

Random rand = new Random();
var newFormat = DateFormat.yMd().add_jm() ;

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

bool dateFallsInRange(DateTimeRange range, DateTime date){
  return (date.isAfter(range.start) || date.isAtSameMomentAs(range.start)) && (date.isAfter(range.end) || date.isAtSameMomentAs(range.end));
}

getBestFreeTime() async{
  List<DateTime> result = List<DateTime>();


  Map<int, List<DateTimeRange>> allBusyTime = await getBusyTime();

  int timeSlotsToFind = currentUser.getIntensity();
  print("Should find $timeSlotsToFind timeslots per week");

  // recalculate number of timeSlots to find depending on how many days left in the week
  DateTime now = new DateTime.now();
  //Todo: fix this so its more precise later
  int remainingDays = 7 - now.weekday;
  if (remainingDays < timeSlotsToFind){
    timeSlotsToFind = remainingDays+1;
  }

  var weekStr = {1:"mon", 2:"tues", 3:"wed", 4: "thurs", 5:"fri", 6:"sat", 7:"sun"};

  print("Based on today, will find $timeSlotsToFind timeslots for this week");

  List<int> orderedByAvail = allBusyTime.keys.toList()..sort((a, b) {
    return allBusyTime[a].length.compareTo(allBusyTime[b].length);
  });

  // padding the list with empty lists for the next functions to work
  for (int i = now.weekday; i < 8; i++){
    if (!allBusyTime.containsKey(i)){
      orderedByAvail.add(i);
    }
  }



  print("this one here========= ${orderedByAvail}");


  List<DateTimeRange> prefRanges = getPrefRanges(now);

  int chosenRangeInt = rand.nextInt(prefRanges.length); // 0 to x exclusive
  DateTimeRange chosenRange = prefRanges[chosenRangeInt];
  print("CHOSE RANGE $chosenRange");

  for(int i = 0; i < timeSlotsToFind; i++){
    int dayToFind = orderedByAvail[i];
    print("===============Have to find a timeslot of length ${currentUser.getRoutineLen()} for $dayToFind=============");


    DateTime thatDayofWeek = now;

    if (dayToFind != now.weekday){
      thatDayofWeek = now.add(new Duration(days: dayToFind - now.weekday)); // get the month and day
      thatDayofWeek = new DateTime(chosenRange.start.year, chosenRange.start.month, thatDayofWeek.day, chosenRange.start.hour, chosenRange.start.minute);
    }

    print("will now find best free time for day $dayToFind : ${newFormat.format(thatDayofWeek)} which must be within $chosenRange");


    var res = getBestDayFreeTime(chosenRangeInt, weekStr[dayToFind], allBusyTime[dayToFind], thatDayofWeek);
    if (res != null) {
      result.add(res);
    }
  }


print(result);
}


List<DateTimeRange> getPrefRanges(DateTime date){
  var availTimes = currentUser.getAvailWindow().values.toList();

  //Todo: add some kind of widget so they can further refine times, if they want
  Map<int, DateTimeRange> timeRanges = {0: new DateTimeRange(start: DateTime(date.year, date.month, date.day, 6, 0),
                                                                    end: DateTime(date.year, date.month, date.day, 11, 59)),
                                    1: new DateTimeRange(start: DateTime(date.year, date.month, date.day, 12, 0),
                                                                  end: DateTime(date.year, date.month, date.day, 19, 59)),
                                    2: new DateTimeRange(start: DateTime(date.year, date.month, date.day, 20, 00),
                                        end: DateTime(date.year, date.month, date.day, 23, 00))
  };

  List<DateTimeRange> availRanges = List<DateTimeRange>();
  for (int i = 0; i < availTimes.length; i++){
    if (availTimes[i]){
      availRanges.add(timeRanges[i]);

    }
  }
  return availRanges;
}
getBestDayFreeTime(var chosenRangeInt, String day, List<DateTimeRange> busyRanges, DateTime date){

  int NIGHT_END = 1;
  List<DateTimeRange> prefRanges = getPrefRanges(date);
  DateTimeRange chosenRange = prefRanges[chosenRangeInt];

  int upperLim = chosenRange.end.hour;
  int lowerLim = chosenRange.start.hour;
  int timeSlotLen = currentUser.getRoutineLen();


    bool foundTimeSlot = false;
    DateTime timeSlotStart = date;
    DateTime timeSlotEnd = timeSlotStart.add(new Duration(minutes:timeSlotLen));

    int counter= 0;
    while(!foundTimeSlot && timeSlotStart.day == date.day){
        timeSlotStart = date.add(new Duration(minutes:  roundNearestFive((counter * 5) + timeSlotStart.minute) - timeSlotStart.minute));
        timeSlotEnd = timeSlotStart.add(new Duration(minutes:timeSlotLen));

       if(withinRange(timeSlotStart, timeSlotEnd, chosenRange) && !hasTimeConflict(chosenRange, timeSlotStart, timeSlotEnd, busyRanges)){
         print("-FOUND TIME--Valid -- ${newFormat.format(timeSlotStart)} - ${newFormat.format(timeSlotEnd)} within $chosenRange");
         return timeSlotStart;
       }

      counter++;


    }


  print("Could not find a timeSlot for this day");
  print("==============================================");
  return;
}

bool hasTimeConflict(var chosenRange, DateTime timeSlotStart, DateTime timeSlotEnd, List<DateTimeRange> busyRanges) {
  if(busyRanges == null){
    return false;
  }
  for (int i = 0; i < busyRanges.length; i++){
    //Todo: fix so that the ranges are separated by timeAvail range and don't have to iterate over ones that don't apply to the chosen range
    // only check the timeslot against the busyRanges that are within the user's chosenRange
      //print("checking conflict between $timeSlotStart $timeSlotEnd in ${busyRanges[i]}");
      if (hasOverlap(timeSlotStart, timeSlotEnd, busyRanges[i])){
        return true;
      }

  }
  return false;
}

bool withinRange(DateTime timeSlotStart, DateTime timeSlotEnd, DateTimeRange event){
  if (event.start.add(Duration(days:1)) == event.end){
    return false;
  }
  if (!((timeSlotStart.isAfter(event.start) || timeSlotStart.isAtSameMomentAs(event.start))
      && !(timeSlotEnd.isAfter(event.end) || timeSlotEnd.isAtSameMomentAs(event.end)))) {
    return false;
  }
  return true;
}

bool hasOverlap(DateTime timeSlotStart, DateTime timeSlotEnd, DateTimeRange event){
  // in the case that the timeSlot starts during the event
  if (timeSlotStart.isAfter(event.start) && timeSlotStart.isBefore(event.end)){
    return true;
  }
  // in the case that the timeSlot ends during the event
  if(timeSlotEnd.isAfter(event.start) && timeSlotEnd.isBefore(event.end)){
    return true;
  }
  // in the case that they start at the same time
  if(timeSlotStart.hour == event.start.hour && timeSlotStart.minute == timeSlotStart.minute){
    return true;
  }
  return false;
}

int roundNearestFive(int val){
  if(val%5 !=0){
    val += 5 - (val%5);
  }
  return val;

}
