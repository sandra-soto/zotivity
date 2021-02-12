import 'dart:convert';

import 'package:zotivity/models/activityCategory.dart';

class User {
  // static const String cookingCategory = 'cooking';
  // static const String bakingCategory = 'baking';
  String id, firstName, lastName, email;
  int age;
  Map<ActivityCategory, bool> interests;

  User() {
    id = '';
    firstName = '';
    lastName = '';
    email = '';
    age = -1;
    
    List<bool> vals = List.filled(ActivityCategory.values.length, false);
    interests = Map.fromIterables(ActivityCategory.values, vals);
    // interests = {
    //   cookingCategory: false,
    //   bakingCategory: false
    // };
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

  void setInterest(ActivityCategory category, bool interest) {
    interests[category] = interest;
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

  Map<ActivityCategory, bool> getInterests() {
    return interests;
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
      'interests': {'cooking': interests[ActivityCategory.cooking],'baking': interests[ActivityCategory.baking], 'exercise': interests[ActivityCategory.exercise]}

    };

  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        age = json['age'],
        interests = {ActivityCategory.cooking: json['interests']['cooking'],
                    ActivityCategory.baking : json['interests']['baking'],
                    ActivityCategory.exercise: json['interests']['exercise']};

}