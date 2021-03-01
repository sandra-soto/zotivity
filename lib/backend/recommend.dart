import 'package:get/get.dart';
import 'package:zotivity/backend/firebase.dart';
import 'package:zotivity/backend/globals.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';
import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/screens/RoutinePage.dart';
import 'package:sortedmap/sortedmap.dart';
import '../models/Activity.dart';



void getRoutineRecs() async {
  var activityMap = Map<int, Activity>();
  var activityByScore = new SortedMap(Ordering.byValue());
  List<Activity> weightedActivityList = List<Activity>();

  // person who likes simple indoor activities
  currentUser.setExperience(0);
  currentUser.setFocus(BodyFocus.legs, true);
  currentUser.setFocus(BodyFocus.arms, true);
  currentUser.setFocus(BodyFocus.glutes, true);
  currentUser.setFocus(BodyFocus.full, true);
  currentUser.setInterest(ActivityCategory.indoor, true);
  currentUser.setInterest(ActivityCategory.outdoor, false);
  currentUser.setInterest(ActivityCategory.gym, false);


  //person who likes hardcore gym stuff
  currentUser.setExperience(2);
  currentUser.setFocus(BodyFocus.chest, true);
  currentUser.setFocus(BodyFocus.shoulders, true);
  currentUser.setFocus(BodyFocus.arms, true);
  currentUser.setFocus(BodyFocus.full, false);
  currentUser.setInterest(ActivityCategory.indoor, false);
  currentUser.setInterest(ActivityCategory.outdoor, false);
  currentUser.setInterest(ActivityCategory.gym, true);


  //person who wants to do full activities outside and has no particular focus
  currentUser.setExperience(1);
  currentUser.setFocus(BodyFocus.chest, false);
  currentUser.setFocus(BodyFocus.legs, false);
  currentUser.setFocus(BodyFocus.shoulders, false);
  currentUser.setFocus(BodyFocus.arms, false);
  currentUser.setFocus(BodyFocus.glutes, false);
  currentUser.setFocus(BodyFocus.full, true);
  currentUser.setInterest(ActivityCategory.indoor, false);
  currentUser.setInterest(ActivityCategory.outdoor, true);
  currentUser.setInterest(ActivityCategory.gym, false);


  List<ActivityCategory> userPref = currentUser.getInterests().keys.toList()..removeWhere((key) {
    return currentUser.getInterests()[key] == false;
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
  print(currentUser);

  activityByScore.keys.toList().forEach((key) {
    weightedActivityList.add(activityMap[key]);
  });

  Get.to(() => RoutinePage(items: new List.from(weightedActivityList.reversed)));


}

int getScore(Activity element) {
  int score = 0;
    var weights = {
      "intensity": 5,
      "focus": 10,
      "equipment": 20,
      "time": 3,
    };

    if (currentUser.focus[element.focus]){
      score += (weights["focus"]);
    }
    if(currentUser.getInterests()[ActivityCategory.gym] == true && (element.equipment[0] == Equipment.machine)){
      score += (weights["equipment"]);
    }

    if ((element.equipment[0] == null && currentUser.access[0] == Equipment.none) || currentUser.access.contains(element.equipment[0])){
      score += (weights["equipment"]);
    }
    if (currentUser.experience >= element.intensity) {
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