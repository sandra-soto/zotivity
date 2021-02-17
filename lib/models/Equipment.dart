import 'package:flutter/foundation.dart';

enum Equipment {
  gym,
  bike,
  dumbbells,
  resistance_bands,
  pull_up_bar,
  yoga_mat
}

extension EquipmentString on Equipment {
  String formatString() {
    String temp = this.toString().split('.').last;
    return temp.replaceAll(new RegExp(r'_'), ' ');
  }
}

List<Equipment> getAllCategories() {
  return Equipment.values;
}