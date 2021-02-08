import 'package:zotivity/models/activityCategory.dart';

class User {
  // static const String cookingCategory = 'cooking';
  // static const String bakingCategory = 'baking';

  String firstName, lastName, email;
  int age;
  Map<ActivityCategory, bool> interests;

  User() {
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

  @override
  String toString() {
    return '''
      First name: $firstName
      Last name: $lastName
      age: $age
    ''';
  }
}