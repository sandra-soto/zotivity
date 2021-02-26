import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/models/activityCategory.dart';

import '../models/Activity.dart';

void bwehhh() async {
  List<Activity> activityList = List<Activity>();

  currentUser.setInterest(ActivityCategory.indoor, true);
  currentUser.setInterest(ActivityCategory.outdoor, false);
  currentUser.setInterest(ActivityCategory.gym, false);


  List<ActivityCategory> userPref = currentUser.getInterests().keys.toList()..removeWhere((key) {
    return currentUser.getInterests()[key] == false;
  });

  for(int i = 0; i < userPref.length; i++){
    print(userPref[i]);
    List<Activity> be = await getActivitiesByCategory(userPref[i].str);
    activityList.addAll(be);
  }

  print(activityList);


}

List<Activity> makeRecommendation(){
  print(getActivitiesByCategory(ActivityCategory.indoor.str));
}