import 'package:flutter/foundation.dart';

enum Equipment {
  none, 
  gym,
  bike,
  dumbbells,
  resistance_bands,
  pull_up_bar,
  yoga_mat
}

extension EquipmentString on Equipment {
  String get str => describeEnum(this);
}

List<Equipment> getAllCategories() {
  return Equipment.values;
}