import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/screens/RoutinePage.dart';

import '../models/Activity.dart';

void getRoutineRecs() async {
  List<Activity> activityList = List<Activity>();

  currentUser.setInterest(ActivityCategory.indoor, true);
  currentUser.setInterest(ActivityCategory.outdoor, false);
  currentUser.setInterest(ActivityCategory.gym, true);


  List<ActivityCategory> userPref = currentUser.getInterests().keys.toList()..removeWhere((key) {
    return currentUser.getInterests()[key] == false;
  });

  for(int i = 0; i < userPref.length; i++){
    print(userPref[i]);
    activityList.addAll(await getActivitiesByCategory(userPref[i].str));
  }

  activityList.removeWhere((element) => matchPrefs(element) == false);
  activityList.forEach((element) {print(element);});
  Get.to(() => RoutinePage(items: activityList));


}

matchPrefs(Activity element) {
  print(currentUser);
  if(outdoorWeather()){
  }
  if (!currentUser.focus[element.focus]){ // currentUser.focus is a map of <focus, bool>
    return false;
  }

}

//Todo: hook this up with weather API
bool outdoorWeather() {
  return true;
}

List<Activity> makeRecommendation(){
  print(getActivitiesByCategory(ActivityCategory.indoor.str));
}