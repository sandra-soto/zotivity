import 'dart:convert';

import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';

class ZotUser {
  static const String TIME_MORN = "morning";
  static const String TIME_NOON = "noon";
  static const String TIME_NIGHT = "night";

  String firstName, lastName, email;
  int age, experience, intensity, routineLen, goal;  // experience can be from 0 - 2? 0 = beginner to 2 = advanced
  Map<ActivityCategory, bool> interests;
  Map<BodyFocus, bool> focus;
  Map<String, bool> availWindow;
  List<Equipment> access; // idk if list or map is best here
  List<int> dontRecommend;
  List<int> recommend;
  List<int> weightProgress;

  ZotUser() {
    firstName = lastName = email =  '';
    age = experience = goal = -1; 
    intensity = 3;
    routineLen = 30;
    interests = Map();
    focus = Map();
    availWindow = Map();
    access = [];
    dontRecommend = recommend = weightProgress = [];
  }

  void setFirstName(String name) {
    firstName = name;
  }

  void setLastName(String name) {
    lastName = name;
  }

  void setEmail(String _email) {
    email = _email;
  }

  void setAge(int _age) {
    age = _age;
  }

  void setExperience(int _experience) {
    experience = _experience;
  }

  void setGoal(int _goal) {
    goal = _goal;
  }

  void setIntensity(int _intensity) {
    intensity = _intensity;
  }

  void setRoutineLen(int len) {
    routineLen = len;
  }

  void setInterest(ActivityCategory category, bool interest) {
    interests[category] = interest;
  }

  void setFocus(BodyFocus group, bool interest) {
    focus[group] = interest;
  }

  void setWindow(String window, bool avail) {
    availWindow[window] = avail;
  }

  bool addEquipment(Equipment equipment) {
    if (access.contains(equipment)) {
      return false;
    }

    access.add(equipment);
    return true;
  }

  bool removeEquipment(Equipment equipment) {
    return access.remove(equipment);
  }

  bool addGoodRec(int rec) {
    if (recommend.contains(rec)) {
      return false;
    }

    recommend.add(rec);
    return true;
  }

  bool removeGoodRec(int rec) {
    return recommend.remove(rec);
  }

  bool addBadRec(int rec) {
    if (dontRecommend.contains(rec)) {
      return false;
    }

    dontRecommend.add(rec);
    return true;
  }

  bool removeBadRec(int rec) {
    return dontRecommend.remove(rec);
  }

  bool addWeight(int weight) {
    if (weight < 0) {
      return false;
    }

    weightProgress.add(weight);
    return true;
  }

  String getFirstName() => this.firstName;
  String getLastName() => this.lastName;
  String getEmail() => this.email;
  int getAge() => this.age;
  int getExperience() => this.experience;
  int getIntensity() => this.intensity;
  int getRoutineLen() => this.routineLen;
  int getGoal() => this.goal;
  Map<ActivityCategory, bool> getInterests() => this.interests;
  Map<BodyFocus, bool> getFocus() => this.focus;
  Map<String, bool> getAvailWindow() => this.availWindow;
  List<Equipment> getAccess() => this.access;
  List<int> getGoodRecs() => this.recommend;
  List<int> getBadRecs() => this.dontRecommend;
  List<int> getWeightProgress() => this.weightProgress;

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }

  // Convert a user into a Map.
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'experience': experience,
      'intensity': intensity,
      'routineLen': routineLen,
      'goal': goal,
      'interests': {
        'indoor': interests[ActivityCategory.indoor],
        'outdoor': interests[ActivityCategory.outdoor], 
        'gym': interests[ActivityCategory.gym]
      },
      'focus': {
        'arms' : focus[BodyFocus.arms],
        'chest': focus[BodyFocus.chest],
        'shoulders': focus[BodyFocus.shoulders],
        'torso': focus[BodyFocus.torso],
        'back': focus[BodyFocus.back],
        'glutes': focus[BodyFocus.glutes],
        'legs': focus[BodyFocus.legs],
        'full': focus[BodyFocus.full],
      },
      'availWindow': {
        TIME_MORN: availWindow[TIME_MORN],
        TIME_NOON: availWindow[TIME_NOON],
        TIME_NIGHT: availWindow[TIME_NIGHT],
      },
      'access': access.join(','),
      'recommend': recommend.join(','),
      'dontRecommend': dontRecommend.join(','),
      'weightProgress': weightProgress.join(',')
    };
  }


// couldn't find a better way to do this via code so itll have to be updated each time the user class or enums change
  ZotUser.fromJson(Map<String, dynamic> json)
      :
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        age = json['age'],
        interests = {ActivityCategory.indoor: json['interests']['indoor'],
                    ActivityCategory.outdoor : json['interests']['outdoor'],
                    ActivityCategory.gym: json['interests']['gym']},
        experience = json['experience'],
        intensity = json['intensity'],
        routineLen = json['routineLen'],
        focus = {BodyFocus.arms: json['focus']['arms'],
                BodyFocus.chest : json['focus']['chest'],
                BodyFocus.shoulders : json['focus']['shoulders'],
                BodyFocus.torso : json['focus']['torso'],
                BodyFocus.back : json['focus']['back'],
                BodyFocus.glutes : json['focus']['glutes'],
                BodyFocus.legs : json['focus']['legs'],
                BodyFocus.full : json['focus']['full'],

        },
        availWindow = {TIME_MORN: json['availWindow'][TIME_MORN],
                      TIME_NOON: json['availWindow'][TIME_NOON],
                      TIME_NIGHT: json['availWindow'][TIME_NIGHT]
        },
        access =  stringToList(json['access']);

}

