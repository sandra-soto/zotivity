import 'package:flutter/foundation.dart';

enum Equipment {
  equipment_none,
  equipment_gym,
  equipment_bike,
  equipment_dumbbells,
  equipment_resistance_bands,
  equipment_pull_up_bar,
  equipment_yoga_mat
}

extension EquipmentString on Equipment {
  String get str => describeEnum(this);
}

List<Equipment> getAllCategories() {
  return Equipment.values;
}