import 'package:flutter/foundation.dart';

enum ActivityCategory {
  exercise,
  cooking,
  baking
}
extension ActivityCategoryString on ActivityCategory {
  String get str => describeEnum(this);
}
List<ActivityCategory> getAllCategories() {
return ActivityCategory.values;
}