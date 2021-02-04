class User {
  static const String cookingCategory = 'cooking';
  static const String bakingCategory = 'baking';

  String firstName, lastName, email;
  int age;
  Map<String, bool> interests;

  User() {
    firstName = '';
    lastName = '';
    email = '';
    age = -1;
    interests = {
      cookingCategory: false,
      bakingCategory: false
    };
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

  void setInterests(Map<String, bool> _interests) {
    interests = Map.from(_interests);
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