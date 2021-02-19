import 'package:flutter/foundation.dart';

enum BodyFocus {
  bodyfocus_arms,
  bodyfocus_chest,
  bodyfocus_shoulders,
  bodyfocus_back,
  bodyfocus_legs,
  bodyfocus_none,
}

extension BodyFocusString on BodyFocus {
  String get str => describeEnum(this);
}

List<BodyFocus> getAllCategories() {
  return BodyFocus.values;
}