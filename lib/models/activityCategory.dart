import 'package:flutter/foundation.dart';

enum ActivityCategory {
  indoor,
  outdoor,
  gym
}

extension ActivityCategoryString on ActivityCategory {
  String get str => describeEnum(this);
}

List<ActivityCategory> getAllCategories() {
  return ActivityCategory.values;
}