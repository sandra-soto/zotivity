import 'package:get/get.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/screens/RoutinePage.dart';
import 'package:sortedmap/sortedmap.dart';
import '../models/Activity.dart';
import 'package:zotivity/screens/CalendarPage.dart';



Future<List<Activity>> getRoutineRecs() async {
  var activityMap = Map<int, Activity>();
  var activityByScore = new SortedMap(Ordering.byValue());
  List<Activity> weightedActivityList = List<Activity>();

  // person who likes simple indoor activities
  currentZotUser.setExperience(0);
  currentZotUser.setFocus(BodyFocus.legs, true);
  currentZotUser.setFocus(BodyFocus.arms, true);
  currentZotUser.setFocus(BodyFocus.glutes, true);
  currentZotUser.setFocus(BodyFocus.full, true);
  currentZotUser.setInterest(ActivityCategory.indoor, true);
  currentZotUser.setInterest(ActivityCategory.outdoor, false);
  currentZotUser.setInterest(ActivityCategory.gym, false);


  //person who likes hardcore gym stuff
  currentZotUser.setExperience(2);
  currentZotUser.setFocus(BodyFocus.chest, true);
  currentZotUser.setFocus(BodyFocus.shoulders, true);
  currentZotUser.setFocus(BodyFocus.arms, true);
  currentZotUser.setFocus(BodyFocus.full, false);
  currentZotUser.setInterest(ActivityCategory.indoor, false);
  currentZotUser.setInterest(ActivityCategory.outdoor, false);
  currentZotUser.setInterest(ActivityCategory.gym, true);


  //person who wants to do full activities outside and has no particular focus
  currentZotUser.setExperience(1);
  currentZotUser.setFocus(BodyFocus.chest, false);
  currentZotUser.setFocus(BodyFocus.legs, false);
  currentZotUser.setFocus(BodyFocus.shoulders, false);
  currentZotUser.setFocus(BodyFocus.arms, false);
  currentZotUser.setFocus(BodyFocus.glutes, false);
  currentZotUser.setFocus(BodyFocus.full, true);
  currentZotUser.setInterest(ActivityCategory.indoor, false);
  currentZotUser.setInterest(ActivityCategory.outdoor, true);
  currentZotUser.setInterest(ActivityCategory.gym, false);


  List<ActivityCategory> userPref = currentZotUser.getInterests().keys.toList()..removeWhere((key) {
    return currentZotUser.getInterests()[key] == false;
  });

  for(int i = 0; i < userPref.length; i++){
    print(userPref[i]);
    activityMap.addAll(await getMapActivitiesByCategory(userPref[i].str));
    activityMap.keys.toList().forEach((key) {
      activityByScore[key] = getScore(activityMap[key]);
      print("$key - ${activityMap[key].title} : #${activityByScore[key]}");
    });
  }

  //activityMap.removeWhere((element) => matchPrefs(element) == false);
  //activityMap.forEach((element) {print(element);});

  print(activityByScore);
  print(currentZotUser);

  activityByScore.keys.toList().forEach((key) {
    weightedActivityList.add(activityMap[key]);
  });

  return Get.to(() => RoutinePage(items: List.from(weightedActivityList.reversed)));
}

int getScore(Activity element) {
  int score = 0;
    var weights = {
      "intensity": 5,
      "focus": 10,
      "equipment": 20,
      "time": 3,
    };

    if (currentZotUser.focus[element.focus]){
      score += (weights["focus"]);
    }
    if(currentZotUser.getInterests()[ActivityCategory.gym] == true && (element.equipment[0] == Equipment.machine)){
      score += (weights["equipment"]);
    }

    if ((element.equipment[0] == null && currentZotUser.access[0] == Equipment.none) || currentZotUser.access.contains(element.equipment[0])){
      score += (weights["equipment"]);
    }
    if (currentZotUser.experience >= element.intensity) {
      score += (weights["intensity"]);
    }

    // Todo: connect calendar call and recommendation call
    if (element.time <= 60){
      score += (weights["time"]);
    }

    return score;

  }





//Todo: hook this up with weather API
bool outdoorWeather() {
  return true;
}

List<Activity> makeRecommendation(){
  print(getActivitiesByCategory(ActivityCategory.indoor.str));
}