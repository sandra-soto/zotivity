import 'package:flutter/foundation.dart';

enum BodyFocus {
  arms,
  chest,
  shoulders,
  back,
  legs,
}

extension BodyFocusString on BodyFocus {
  String get str => this.toString().split('.').last;
}

List<BodyFocus> getAllCategories() {
  return BodyFocus.values;
}