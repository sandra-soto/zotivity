import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';

class Activity {
  ActivityCategory category;
  BodyFocus focus;
  String title, imgLink, description, resources;
  int reps, time, intensity;  // intensity can be from 0 - 2? 0 = easy to 2 = hard
  List<Equipment> equipment; // idk if list or map is best here

// Todo: fix default parameters to point to a blank image or smth
  Activity(title, category, reps, time, intensity, focus, description, equipment, [imgLink="", resources=""]){
    this.title = title;
    this.category = category;
    this.reps = reps;
    this.time = time;
    this.intensity = intensity;
    this.focus = focus;
    this.description = description;
    this.equipment = equipment;
    this.imgLink = imgLink;
    this.resources = resources;
  }

  Activity.fromList(List<dynamic> attributes) {
    this.title = attributes[0];
    this.category = catToEnum(attributes[1]);
    this.focus = focusToEnum(attributes[2]);
    this.reps = (attributes[3].runtimeType == int) ? attributes[3]: int.parse(attributes[3]);
    this.time = (attributes[4].runtimeType == int) ? attributes[4]: int.parse(attributes[4]);
    this.intensity = (attributes[5].runtimeType == int) ? attributes[5]: int.parse(attributes[5]);
    this.equipment = stringToList(attributes[6]);
    this.imgLink = attributes[7];
    this.resources = attributes[8];
    this.description = attributes[9];
  }

  String getTitle() => this.title;
  String getImgLink() => this.imgLink;
  ActivityCategory getCategory()  => this.category;
  int getReps() => this.reps;
  int getTime() => this.time;
  int getIntensity() => this.intensity;
  BodyFocus getFocus() => this.focus;
  String getDescription() => this.description;
  List<Equipment> getEquipment() => this.equipment;
  String getResources()  => this.resources;

  @override
  String toString(){
    return '''
    Title: $title
    Image Link: $imgLink
    Category: $category
    Reps: $reps
    Time: $time
    Intensity: $intensity
    Focus: $focus
    Description: $description
    Resources: $resources
    Equipment: $equipment
    ''';
  }

  Map<String, dynamic> toMap() {
    List<String> equip = List.empty(growable: true);
    for (var e in equipment) {
      equip.add(e.formatString());
    }

    return {
      'title': title,
      'category': category.str,
      'reps': reps,
      'time': time,
      'intensity': intensity,
      'focus': focus.str,
      'imgLink': imgLink,
      'description': description,
      'resources': resources,
      'equipment': equip.join(", ")
    };
  }

  Activity.fromJson(Map<String, dynamic> json) :
    title = json['title'],
    category = catToEnum(json['category']),
    reps = json['reps'],
    time = json['time'],
    intensity = json['intensity'],
    focus = focusToEnum(json['focus']),
    imgLink = json['imgLink'],
    description = json['description'],
    resources = json['resources'],
    equipment = stringToList(json['equipment']);

}