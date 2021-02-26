import 'package:flutter/foundation.dart';

enum Equipment {
  bike,
  dumbbells,
  barbell,
  resistance_bands,
  pull_up_bar,
  yoga_mat,
  bench,
  machine,
  // none
}

extension EquipmentString on Equipment {
  String formatString() {
    String temp = this.toString().split('.').last;
    return temp.replaceAll(new RegExp(r'_'), ' ');
  }
}

Equipment equipToEnum(String s) {
  for (var e in Equipment.values) {
    if (e.formatString() == s) {
      return e;
    }
  }

  return null;
}

List<Equipment> stringToList(String list) {
  List<Equipment> retList = List.empty(growable: true);
  if (list == null) {
    return retList;
  }

  for (var s in list.split(", ")) {
    if (s == '') { // only one item
      retList.add(equipToEnum(list));
      break;
    }

    retList.add(equipToEnum(s));
  }

  return retList;
}