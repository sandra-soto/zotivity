import 'dart:convert';

import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';

class User {
  static const String TIME_MORN = "morning";
  static const String TIME_NOON = "noon";
  static const String TIME_NIGHT = "night";

  String id, firstName, lastName, email;
  int age, experience, intensity, routineLen;  // experience can be from 0 - 2? 0 = beginner to 2 = advanced
  Map<ActivityCategory, bool> interests;
  Map<BodyFocus, bool> focus;
  Map<String, bool> availWindow;
  List<Equipment> access; // idk if list or map is best here

  User() {
    id = firstName = lastName = email =  '';
    age = experience = intensity = routineLen = -1;
    interests = Map();
    focus = Map();
    availWindow = Map();
    access = [];
  }

  void setId(String _id){
    id = _id;
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

  String getId() {
    return id;
  }

  String getFirstName() {
    return firstName;
  }

  String getLastName() {
    return lastName;
  }

  String getEmail() {
    return email;
  }

  int getAge() {
    return age;
  }

  int getExperience() {
    return experience;
  }

  int getIntensity() {
    return intensity;
  }

  int getRoutineLen() {
    return routineLen;
  }

  Map<ActivityCategory, bool> getInterests() {
    return interests;
  }

  Map<BodyFocus, bool> getFocus() {
    return focus;
  }

  Map<String, bool> getAvailWindow() {
    return availWindow;
  }

  List<Equipment> getAccess() {
    return access;
  }

  @override
  String toString() {
    String interestsStr = '{';
    for (var k in interests.keys) {
      interestsStr += "$k:${interests[k]},";
    }

    return '''
      User id: $id
      First name: $firstName
      Last name: $lastName
      age: $age
      interests: $interestsStr}'
    ''';
  }

  // Convert a user into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
    // Todo: add other values like preferences to db representation
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'interests': {'indoor': interests[ActivityCategory.indoor],'outdoor': interests[ActivityCategory.outdoor], 'gym': interests[ActivityCategory.gym]}

    };

  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        age = json['age'],
        interests = {ActivityCategory.indoor: json['interests']['indoor'],
                    ActivityCategory.outdoor : json['interests']['outdoor'],
                    ActivityCategory.gym: json['interests']['gym']};

}