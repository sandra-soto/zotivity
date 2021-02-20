import 'package:flutter/foundation.dart';

enum BodyFocus {
  arms,
  chest,
  shoulders,
  back,
  legs,
  none,
}

extension BodyFocusString on BodyFocus {
  String get str => this.toString().split('.').last;
}

BodyFocus focusToEnum(String s) {
  for (var b in BodyFocus.values) {
    if (b.str == s) {
      return b;
    }
  }

  return null;
}