import 'package:flutter/foundation.dart';

enum ActivityCategory {
  category_indoor,
  category_outdoor,
  category_gym
}

extension ActivityCategoryString on ActivityCategory {
  String get str => describeEnum(this);
}

ActivityCategory catToEnum(String s) {
  for (var c in ActivityCategory.values) {
    if (c.str == s) {
      return c;
    }
  }

  return null;
}