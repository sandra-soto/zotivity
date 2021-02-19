import 'package:flutter/foundation.dart';

enum ActivityCategory {
  category_indoor,
  category_outdoor,
  category_gym
}

extension ActivityCategoryString on ActivityCategory {
  String get str => describeEnum(this);
}

List<ActivityCategory> getAllCategories() {
  return ActivityCategory.values;
}